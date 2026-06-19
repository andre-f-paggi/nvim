-- mini.nvim: a couple of small, focused modules.
-- (The statusline is handled by lualine instead of mini.statusline.)
return {
  'echasnovski/mini.nvim',
  -- Provides the treesitter queries (@function.outer, etc.) used by mini.ai below.
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  config = function()
    local ai = require 'mini.ai'

    -- Better Around/Inside text objects, extended with treesitter objects so you
    -- can select whole functions/classes/blocks:
    --   vif / vaf  inside / around a FUNCTION (definition)
    --   vic / vac  inside / around a CLASS
    --   vio / vao  inside / around an if / loop block
    -- plus the built-ins: va) vi{ vi[ vi" vit viw vip, etc.
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
    -- closes the window (or Neovim). See custom/plugins/bufferline.lua.
    require('mini.bufremove').setup()
  end,
}
