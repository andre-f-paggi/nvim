-- Indentation guide lines (including on blank lines), with scope highlighting.
-- Toggle the guides with <leader>ui. See `:help ibl`.
require('ibl').setup {}

vim.keymap.set('n', '<leader>ui', '<cmd>IBLToggle<cr>', { desc = 'Toggle indent guides' })
