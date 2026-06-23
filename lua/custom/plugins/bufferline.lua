-- Buffer tabs along the top, like VS Code. Cycle with [b / ]b.
return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  version = '*',
  event = 'VeryLazy',
  opts = {
    options = {
      diagnostics = 'nvim_lsp', -- show LSP errors/warnings on each tab
      always_show_bufferline = false, -- hide when only one buffer is open
    },
  },
  keys = {
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
    { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = 'Pin/unpin buffer' },
    { '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', desc = 'Close other buffers' },
    { '<leader>bd', '<cmd>bdelete<cr>', desc = 'Delete buffer' },
  },
}
