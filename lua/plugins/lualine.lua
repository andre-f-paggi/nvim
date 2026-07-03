-- Statusline. Replaces mini.statusline.
-- `theme = 'auto'` derives colors from the active colorscheme (flexoki).
require('lualine').setup {
  options = {
    theme = 'auto',
    icons_enabled = vim.g.have_nerd_font,
    component_separators = '|',
    section_separators = '',
    globalstatus = true, -- one statusline for all splits
  },
}
