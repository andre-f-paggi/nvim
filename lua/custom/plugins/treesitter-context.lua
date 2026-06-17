-- Sticky header showing the enclosing function/class/block as you scroll deep
-- into a long file. Toggle with <leader>tc.
return {
  'nvim-treesitter/nvim-treesitter-context',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    max_lines = 3, -- how many context lines to show at most
  },
  keys = {
    { '<leader>tc', '<cmd>TSContextToggle<cr>', desc = '[T]oggle Treesitter [C]ontext' },
  },
}
