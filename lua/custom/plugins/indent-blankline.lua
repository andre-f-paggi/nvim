-- Indentation guide lines (including on blank lines), with scope highlighting.
-- Toggle the guides with <leader>ui. See `:help ibl`.
return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {},
  keys = {
    { '<leader>ui', '<cmd>IBLToggle<cr>', desc = 'Toggle indent guides' },
  },
}
