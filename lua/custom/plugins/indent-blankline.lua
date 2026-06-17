-- Indentation guide lines (including on blank lines), with scope highlighting.
-- See `:help ibl`.
return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {},
}
