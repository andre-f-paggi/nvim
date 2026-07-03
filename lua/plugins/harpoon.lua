-- Harpoon (harpoon2): pin a few files and jump between them instantly.
-- Grouped under <leader>h (Harpoon); fast jumps stay on <leader>1-4.
local harpoon = require 'harpoon'
harpoon:setup()

vim.keymap.set('n', '<leader>ha', function()
  harpoon:list():add()
end, { desc = 'Harpoon: [a]dd file' })

vim.keymap.set('n', '<leader>hm', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon: [m]enu' })

vim.keymap.set('n', '<leader>hn', function()
  harpoon:list():next()
end, { desc = 'Harpoon: [n]ext' })

vim.keymap.set('n', '<leader>hp', function()
  harpoon:list():prev()
end, { desc = 'Harpoon: [p]revious' })

-- Fast jumps to harpooned files 1-4 (kept top-level for speed).
for i = 1, 4 do
  vim.keymap.set('n', '<leader>' .. i, function()
    harpoon:list():select(i)
  end, { desc = 'Harpoon: file ' .. i })
end
