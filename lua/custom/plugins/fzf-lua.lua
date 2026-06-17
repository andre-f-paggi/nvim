-- fzf-powered fuzzy finder (alternative to Telescope; faster on huge repos).
-- Mapped under <leader>F so it sits alongside your Telescope maps (<leader>s…).
-- Requires the `fzf` binary on PATH (e.g. `winget install junegunn.fzf`) and
-- ripgrep for live_grep.
return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'FzfLua',
  opts = {},
  keys = {
    { '<leader>Ff', '<cmd>FzfLua files<cr>', desc = 'Fzf: Files' },
    { '<leader>Fg', '<cmd>FzfLua live_grep<cr>', desc = 'Fzf: Live grep' },
    { '<leader>Fb', '<cmd>FzfLua buffers<cr>', desc = 'Fzf: Buffers' },
    { '<leader>Fw', '<cmd>FzfLua grep_cword<cr>', desc = 'Fzf: Word under cursor' },
    { '<leader>Fh', '<cmd>FzfLua helptags<cr>', desc = 'Fzf: Help tags' },
    { '<leader>Fr', '<cmd>FzfLua resume<cr>', desc = 'Fzf: Resume last search' },
  },
}
