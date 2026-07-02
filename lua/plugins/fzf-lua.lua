-- fzf-lua: THE fuzzy finder for this config (files, grep, LSP pickers, ui-select).
-- Replaces Telescope. Requires the `fzf` binary on PATH
-- (e.g. `winget install junegunn.fzf`) and ripgrep for live grep.
--
-- Layout follows the LazyVim/AstroNvim convention:
--   <leader>f … find FILES        <leader>s … SEARCH content
-- All mappings are lowercase — no Shift needed.
local fzf = require 'fzf-lua'
fzf.setup {}
-- Route vim.ui.select (e.g. LSP code-action menus) through fzf-lua.
fzf.register_ui_select()

local map = vim.keymap.set

-- Find (files)
map('n', '<leader>ff', '<cmd>FzfLua files<cr>', { desc = 'Find: files' })
map('n', '<leader>fr', '<cmd>FzfLua oldfiles<cr>', { desc = 'Find: recent files' })
map('n', '<leader>fb', '<cmd>FzfLua buffers<cr>', { desc = 'Find: buffers' })
map('n', '<leader>fn', function()
  fzf.files { cwd = vim.fn.stdpath 'config' }
end, { desc = 'Find: Neovim config files' })

-- Search (content)
map('n', '<leader>sg', '<cmd>FzfLua live_grep<cr>', { desc = 'Search: grep (live regex)' })
map('n', '<leader>sf', '<cmd>FzfLua grep_project<cr>', { desc = 'Search: fuzzy in files' })
map('n', '<leader>sw', '<cmd>FzfLua grep_cword<cr>', { desc = 'Search: word under cursor' })
map('n', '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', { desc = 'Search: diagnostics (buffer)' })
map('n', '<leader>sh', '<cmd>FzfLua helptags<cr>', { desc = 'Search: help tags' })
map('n', '<leader>sk', '<cmd>FzfLua keymaps<cr>', { desc = 'Search: keymaps' })
map('n', '<leader>sr', '<cmd>FzfLua resume<cr>', { desc = 'Search: resume last picker' })
map('n', '<leader>ss', '<cmd>FzfLua lsp_document_symbols<cr>', { desc = 'Search: document symbols' })
map('n', '<leader>s/', '<cmd>FzfLua lines<cr>', { desc = 'Search: lines in open buffers' })
map('n', '<leader>sb', '<cmd>FzfLua lgrep_curbuf<cr>', { desc = 'Search: current buffer' })

-- <leader>/ is the most-reachable key — spend it on project-wide grep (LazyVim convention).
map('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Search: grep (live)' })
