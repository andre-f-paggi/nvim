-- mini.nvim: a couple of small, focused modules.
-- (The statusline is handled by lualine instead of mini.statusline.)
local ai = require 'mini.ai'

-- Better Around/Inside text objects, extended with treesitter objects so you
-- can select whole functions/classes/blocks:
--   vif / vaf  inside / around a FUNCTION (definition)
--   vic / vac  inside / around a CLASS
--   vio / vao  inside / around an if / loop block
-- plus the built-ins: va) vi{ vi[ vi" vit viw vip, etc.
-- (The @function.outer etc. queries come from nvim-treesitter-textobjects.)
ai.setup {
  n_lines = 500,
  custom_textobjects = {
    f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
    c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },
    o = ai.gen_spec.treesitter {
      a = { '@conditional.outer', '@loop.outer' },
      i = { '@conditional.inner', '@loop.inner' },
    },
  },
}

-- Add/delete/replace surroundings (brackets, quotes, tags, ...).
--  e.g. saiw) surround [A]dd [I]nner [W]ord [)]paren
--       sd'   surround [D]elete [']quotes
--       sr)'  surround [R]eplace [)] with [']
require('mini.surround').setup()

-- Smart buffer delete used by the bufferline close mappings: switches the
-- window to another buffer before deleting, so closing a buffer never
-- closes the window (or Neovim). See lua/plugins/bufferline.lua.
require('mini.bufremove').setup()

-- Autocompletion (LSP + fallback) with a signature-help window. Replaces the
-- native vim.lsp.completion path. The LSP capabilities it advertises are wired
-- into the servers in lua/config/lsp.lua. LSP snippets expand via vim.snippet.
--   <C-Space> force-trigger · <C-n>/<C-p> navigate · <C-y> accept · <C-e> cancel
vim.o.completeopt = 'menuone,noselect,fuzzy'
require('mini.completion').setup {
  -- Popup the LSP docs/signature windows without extra keypresses.
  window = {
    info = { border = 'rounded' },
    signature = { border = 'rounded' },
  },
}
