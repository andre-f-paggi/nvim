-- Autocompletion engine (fast, batteries-included). See `:help blink-cmp`.
-- Default keys: <c-y> accept, <c-space> menu/docs, <c-n>/<c-p> next/prev,
-- <c-e> hide, <c-k> signature. Read `:help ins-completion` too.
return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    -- Snippet Engine
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      -- `make install_jsregexp` builds an optional native regex module (only
      -- needed for some LSP snippet transforms). It can't link `lua51` with the
      -- MinGW toolchain on Windows, so skip it there / when `make` is missing.
      -- LuaSnip works fine without it.
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
    },
    'folke/lazydev.nvim',
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions.
      -- 'super-tab' for tab to accept, 'enter' for enter to accept, 'none' for none.
      preset = 'default',
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },

    snippets = { preset = 'luasnip' },

    -- Use the Lua fuzzy matcher by default; 'prefer_rust_with_warning' downloads
    -- a faster prebuilt Rust binary. See :h blink-cmp-config-fuzzy.
    fuzzy = { implementation = 'lua' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  },
}
