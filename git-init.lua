-- Minimal Neovim config for use as git's editor (commit / merge / rebase).
--
-- Loading the full config (see init.lua) takes ~700 ms+ because it eagerly
-- pulls in lualine, treesitter, LSP, mason, dap, fzf, etc. — none of which a
-- commit or merge-message buffer needs. This trimmed init reuses only the
-- editor options, keymaps, and autocommands (which have no plugin deps) and
-- skips every plugin, starting in ~90 ms.
--
-- Wired up in common/git/.gitconfig via:
--   [core] editor = nvim -u NONE --cmd "lua dofile(vim.fn.stdpath('config')..'/git-init.lua')"
-- Loaded with `-u NONE`, so we add the config dir back to the runtimepath
-- ourselves before requiring the shared modules.

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.runtimepath:prepend(vim.fn.stdpath 'config')

-- `-u NONE` disables these; re-enable so gitcommit / git-rebase buffers get
-- filetype detection and syntax highlighting (greyed comments, subject cues).
vim.cmd 'filetype plugin indent on'
vim.cmd 'syntax enable'

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- A colorscheme is a single cheap plugin; pull just that one for visual parity.
pcall(function()
  vim.cmd.packadd 'flexoki-neovim'
  vim.cmd.colorscheme 'flexoki'
end)

-- vim: ts=2 sts=2 sw=2 et
