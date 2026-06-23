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
      build = 'make install_jsregexp',
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
