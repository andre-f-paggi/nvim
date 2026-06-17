-- Harpoon (harpoon2): pin a few files and jump between them instantly.
-- Moved here from the bottom of init.lua so it's a proper, self-contained plugin spec.
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon: [A]dd file' })

    -- Toggle menu moved off <C-e> (which is the default "scroll down one line").
    vim.keymap.set('n', '<leader>e', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon: toggle menu' })

    -- Jump straight to harpooned files 1-4 (reliable keycodes in every terminal).
    for i = 1, 4 do
      vim.keymap.set('n', '<leader>' .. i, function()
        harpoon:list():select(i)
      end, { desc = 'Harpoon: file ' .. i })
    end

    -- Cycle through the list (replaces the old <C-S-P>/<C-S-N> maps, which many
    -- terminals can't send as distinct keycodes).
    vim.keymap.set('n', '<leader>p', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon: previous' })

    vim.keymap.set('n', '<leader>n', function()
      harpoon:list():next()
    end, { desc = 'Harpoon: next' })
  end,
}
