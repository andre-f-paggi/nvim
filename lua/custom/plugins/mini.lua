-- mini.nvim: a couple of small, focused modules.
-- (The statusline is handled by lualine instead of mini.statusline.)
return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside text objects.
    --  e.g. va)  visually select [A]round [)]paren
    --       yinq yank [I]nside [N]ext [Q]uote
    --       ci'  change [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, tags, ...).
    --  e.g. saiw) surround [A]dd [I]nner [W]ord [)]paren
    --       sd'   surround [D]elete [']quotes
    --       sr)'  surround [R]eplace [)] with [']
    require('mini.surround').setup()
  end,
}
