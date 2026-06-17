-- A pretty, navigable panel for diagnostics, LSP references, quickfix, etc.
return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  opts = {},
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Trouble: Workspace Diagnostics' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Trouble: Buffer Diagnostics' },
    { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Trouble: Symbols' },
    { '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'Trouble: LSP Defs/Refs' },
    { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Trouble: Location List' },
    { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Trouble: Quickfix List' },
  },
}
