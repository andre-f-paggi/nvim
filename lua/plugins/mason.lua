-- Mason: installer for external tools ONLY (LSP servers, formatters, debug
-- adapters). Server wiring is native (lua/config/lsp.lua) — no mason-lspconfig.
-- `mason.setup` also prepends Mason's bin dir to PATH so the tools resolve.
-- Check status / install more tools with :Mason.
require('mason').setup {
  -- Extra registry providing the `roslyn`/`rzls` packages for roslyn.nvim.
  registries = {
    'github:mason-org/mason-registry',
    'github:Crashdummyy/mason-registry',
  },
}

-- Declarative install list (Mason package names, NOT lspconfig names).
-- :MasonToolsInstall / :MasonToolsInstallSync to run it manually.
require('mason-tool-installer').setup {
  ensure_installed = {
    -- LSP servers (see vim.lsp.enable in lua/config/lsp.lua)
    'lua-language-server', -- lua_ls
    'typescript-language-server', -- ts_ls
    'eslint-lsp', -- eslint
    'powershell-editor-services', -- powershell_es
    'bash-language-server', -- bashls
    'json-lsp', -- jsonls
    'yaml-language-server', -- yamlls
    'marksman', -- marksman (Markdown)
    'rust-analyzer', -- rust_analyzer
    'basedpyright', -- basedpyright (Python)
    'ruby-lsp', -- ruby_lsp
    'gopls', -- gopls (Go)
    'roslyn', -- C# (from the Crashdummyy registry, used by roslyn.nvim)

    -- Formatters (conform.nvim)
    'stylua',
    'prettierd',

    -- Debug adapters (nvim-dap)
    'netcoredbg',

    -- Treesitter 'main' branch builds parsers with the tree-sitter CLI
    -- (a C compiler alone is no longer enough). Provided here so it's on PATH.
    'tree-sitter-cli',
  },
}
