-- Neo-tree: file-explorer sidebar. Toggle/reveal it with <leader>e.
-- https://github.com/nvim-neo-tree/neo-tree.nvim
require('neo-tree').setup {
  close_if_last_window = true, -- don't leave an empty neo-tree as the last window
  filesystem = {
    follow_current_file = { enabled = true }, -- highlight the file you're editing
    use_libuv_file_watcher = true, -- refresh the tree on external file changes
    window = {
      mappings = {
        -- Pressing <leader>e again from inside the tree closes it.
        ['<leader>e'] = 'close_window',
      },
    },
  },
}

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle reveal<cr>', { desc = 'Explorer (neo-tree)', silent = true })
