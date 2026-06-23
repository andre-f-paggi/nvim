-- A pretty, navigable panel for diagnostics, LSP references, quickfix, etc.
-- All keys lowercase under <leader>x — no Shift needed.
return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  opts = {},
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Trouble: Workspace Diagnostics' },
    { '<leader>xb', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Trouble: Buffer Diagnostics' },
    { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Trouble: Symbols' },
    { '<leader>xr', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'Trouble: LSP Defs/Refs' },
    { '<leader>xl', '<cmd>Trouble loclist toggle<cr>', desc = 'Trouble: Location List' },
    { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Trouble: Quickfix List' },
  },
}
