-- A pretty, navigable panel for diagnostics, LSP references, quickfix, etc.
-- All keys lowercase under <leader>x — no Shift needed.
require('trouble').setup {}

local map = vim.keymap.set
map('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Trouble: Workspace Diagnostics' })
map('n', '<leader>xb', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Trouble: Buffer Diagnostics' })
map('n', '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Trouble: Symbols' })
map('n', '<leader>xr', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'Trouble: LSP Defs/Refs' })
map('n', '<leader>xl', '<cmd>Trouble loclist toggle<cr>', { desc = 'Trouble: Location List' })
map('n', '<leader>xq', '<cmd>Trouble qflist toggle<cr>', { desc = 'Trouble: Quickfix List' })
