-- Statusline. Replaces mini.statusline (which is disabled in init.lua).
-- `theme = 'auto'` derives colors from the active colorscheme (flexoki).
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  opts = {
    options = {
      theme = 'auto',
      icons_enabled = vim.g.have_nerd_font,
      component_separators = '|',
      section_separators = '',
      globalstatus = true, -- one statusline for all splits
    },
  },
}
