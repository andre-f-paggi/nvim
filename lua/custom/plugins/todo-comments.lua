-- Highlight and search TODO / FIXME / HACK / NOTE comments.
-- Navigate with ]t / [t; browse every todo in the Trouble panel with <leader>xt.
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
  keys = {
    {
      ']t',
      function()
        require('todo-comments').jump_next()
      end,
      desc = 'Next todo comment',
    },
    {
      '[t',
      function()
        require('todo-comments').jump_prev()
      end,
      desc = 'Previous todo comment',
    },
    -- Lives under the <leader>x (Trouble) group alongside the other lists.
    { '<leader>xt', '<cmd>TodoTrouble<cr>', desc = 'Trouble: Todo comments' },
  },
}
