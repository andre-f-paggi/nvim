-- fzf-powered fuzzy finder (alternative to Telescope; faster on huge repos).
-- Mapped under <leader>z (z = "fuzzy") so no Shift is needed and it doesn't
-- clash with Telescope (<leader>s) or format (<leader>f).
-- Requires the `fzf` binary on PATH (e.g. `winget install junegunn.fzf`) and
-- ripgrep for live_grep.
return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'FzfLua',
  opts = {},
  keys = {
    { '<leader>zf', '<cmd>FzfLua files<cr>', desc = 'Fzf: Files' },
    { '<leader>zg', '<cmd>FzfLua live_grep<cr>', desc = 'Fzf: Live grep' },
    { '<leader>zb', '<cmd>FzfLua buffers<cr>', desc = 'Fzf: Buffers' },
    { '<leader>zw', '<cmd>FzfLua grep_cword<cr>', desc = 'Fzf: Word under cursor' },
    { '<leader>zh', '<cmd>FzfLua helptags<cr>', desc = 'Fzf: Help tags' },
    { '<leader>zr', '<cmd>FzfLua resume<cr>', desc = 'Fzf: Resume last search' },
  },
}
