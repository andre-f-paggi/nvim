-- Sticky header showing the enclosing function/class/block as you scroll deep
-- into a long file. Toggle with <leader>uc.
require('treesitter-context').setup {
  max_lines = 3, -- how many context lines to show at most
}

vim.keymap.set('n', '<leader>uc', '<cmd>TSContext toggle<cr>', { desc = 'Toggle Treesitter [C]ontext' })
