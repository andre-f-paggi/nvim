-- [[ LSP — native vim.lsp.config / vim.lsp.enable ]]  See `:help lsp`
-- nvim-lspconfig provides the base config for each server (its lsp/*.lua
-- files); overrides below are merged via vim.lsp.config(). Binaries are
-- installed by Mason (see lua/plugins/mason.lua).

-- Buffer-local keymaps + niceties, run every time a server attaches.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('config-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Rename the variable under your cursor.
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action; cursor on an error/suggestion to activate.
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

    -- Find references for the word under your cursor.
    map('grr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')

    -- Jump to the implementation of the word under your cursor.
    map('gri', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')

    -- Jump to the definition of the word under your cursor. <C-t> jumps back.
    map('grd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')

    -- WARN: Goto DECLARATION, not definition (e.g. a C header).
    map('grc', vim.lsp.buf.declaration, '[G]oto De[c]laration')

    -- Fuzzy find all symbols in the current document / whole workspace.
    map('grs', require('fzf-lua').lsp_document_symbols, 'Document [s]ymbols')
    map('grw', require('fzf-lua').lsp_live_workspace_symbols, '[w]orkspace Symbols')

    -- Jump to the definition of the TYPE of the word under your cursor.
    map('grt', require('fzf-lua').lsp_typedefs, '[G]oto [T]ype Definition')

    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

    -- Highlight references of the word under the cursor when it rests there;
    -- clear the highlights when it moves. See `:help CursorHold`.
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('config-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('config-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'config-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- Toggle inlay hints, when the server supports them.
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>uh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, 'Toggle Inlay [H]ints')
    end
  end,
})

-- Toggle all LSP clients for the current buffer on/off.
-- Useful when LSP is too heavy (e.g. Roslyn on large C# solutions).
vim.keymap.set('n', '<leader>ul', function()
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if #clients > 0 then
    vim.lsp.stop_client(clients)
    vim.notify('LSP stopped', vim.log.levels.WARN)
  else
    vim.api.nvim_exec_autocmds('FileType', { buf = 0 })
    vim.notify('LSP started', vim.log.levels.INFO)
  end
end, { desc = 'Toggle [l]sp (this buffer)' })

-- Diagnostic Config. See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
}

-- Broadcast the completion capabilities from mini.completion to every server,
-- so LSP completion items (snippets, extra edits, docs) are advertised. The
-- '*' config is merged into each server's config by the LSP client.
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_mc, mc = pcall(require, 'mini.completion')
if ok_mc and mc.get_lsp_capabilities then
  capabilities = vim.tbl_deep_extend('force', capabilities, mc.get_lsp_capabilities())
end
vim.lsp.config('*', { capabilities = capabilities })

-- Per-server overrides, merged on top of nvim-lspconfig's base configs.
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      -- You can toggle below to ignore lua_ls's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
})

-- PowerShell Editor Services is a zip bundle, not a bare binary; point the
-- config at Mason's install of it. First start is slow while PSES spins up.
vim.lsp.config('powershell_es', {
  bundle_path = vim.fn.stdpath 'data' .. '/mason/packages/powershell-editor-services',
})

-- Servers to activate (C# is handled separately by roslyn.nvim).
-- Each name maps to a config shipped by nvim-lspconfig; the matching binary
-- is in the ensure_installed list in lua/plugins/mason.lua.
vim.lsp.enable {
  'lua_ls', -- Lua (this config)
  'ts_ls', -- TypeScript / JavaScript (+ JSX/TSX)
  'eslint', -- lint diagnostics + gra auto-fixes (attaches only with an eslint config)
  'powershell_es', -- PowerShell
  'bashls', -- bash / sh / zsh scripts
  'jsonls', -- JSON / JSONC
  'yamlls', -- YAML
  'marksman', -- Markdown
  'rust_analyzer', -- Rust
  'basedpyright', -- Python
  'ruby_lsp', -- Ruby
  'gopls', -- Go
}
