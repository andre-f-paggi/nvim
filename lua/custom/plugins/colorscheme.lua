-- Colorscheme. High priority so it applies before other UI plugins load.
return {
  'kepano/flexoki-neovim',
  name = 'flexoki',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'flexoki-dark'
  end,
}
