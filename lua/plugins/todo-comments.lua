-- Highlight and search TODO / FIXME / HACK / NOTE comments.
-- Navigate with ]t / [t; browse every todo in the Trouble panel with <leader>xt.
require('todo-comments').setup { signs = false }

vim.keymap.set('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'Next todo comment' })

vim.keymap.set('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'Previous todo comment' })

-- Lives under the <leader>x (Trouble) group alongside the other lists.
vim.keymap.set('n', '<leader>xt', '<cmd>TodoTrouble<cr>', { desc = 'Trouble: Todo comments' })
