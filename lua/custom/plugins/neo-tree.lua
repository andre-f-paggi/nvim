-- Neo-tree: file-explorer sidebar. Toggle/reveal it with <leader>e.
-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- file-type icons (needs a Nerd Font)
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', '<cmd>Neotree toggle reveal<cr>', desc = 'Explorer (neo-tree)', silent = true },
  },
  opts = {
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
  },
}
