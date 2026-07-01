-- fzf-lua: THE fuzzy finder for this config (files, grep, LSP pickers, ui-select).
-- Replaces Telescope. Requires the `fzf` binary on PATH
-- (e.g. `winget install junegunn.fzf`) and ripgrep for live grep.
--
-- Layout follows the LazyVim/AstroNvim convention:
--   <leader>f … find FILES        <leader>s … SEARCH content
-- All mappings are lowercase — no Shift needed.
return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'FzfLua',
  keys = {
    -- Find (files)
    { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Find: files' },
    { '<leader>fr', '<cmd>FzfLua oldfiles<cr>', desc = 'Find: recent files' },
    { '<leader>fb', '<cmd>FzfLua buffers<cr>', desc = 'Find: buffers' },
    {
      '<leader>fn',
      function()
        require('fzf-lua').files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Find: Neovim config files',
    },

    -- Search (content)
    { '<leader>sg', '<cmd>FzfLua live_grep<cr>', desc = 'Search: grep (live regex)' },
    { '<leader>sf', '<cmd>FzfLua grep_project<cr>', desc = 'Search: fuzzy in files' },
    { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = 'Search: word under cursor' },
    { '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Search: diagnostics (buffer)' },
    { '<leader>sh', '<cmd>FzfLua helptags<cr>', desc = 'Search: help tags' },
    { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = 'Search: keymaps' },
    { '<leader>sr', '<cmd>FzfLua resume<cr>', desc = 'Search: resume last picker' },
    { '<leader>ss', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'Search: document symbols' },
    { '<leader>s/', '<cmd>FzfLua lines<cr>', desc = 'Search: lines in open buffers' },
    { '<leader>sb', '<cmd>FzfLua lgrep_curbuf<cr>', desc = 'Search: current buffer' },

    -- <leader>/ is the most-reachable key — spend it on project-wide grep (LazyVim convention).
    { '<leader>/', '<cmd>FzfLua live_grep<cr>', desc = 'Search: grep (live)' },
  },
  opts = {},
  config = function(_, opts)
    local fzf = require 'fzf-lua'
    fzf.setup(opts)
    -- Route vim.ui.select (e.g. LSP code-action menus) through fzf-lua,
    -- replacing what telescope-ui-select used to do.
    fzf.register_ui_select()
  end,
}
