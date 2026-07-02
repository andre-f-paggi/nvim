-- Neovim entry point.
--
-- Leader keys and the Nerd Font flag must be set BEFORE plugins load, so they
-- live here. Everything else is split into focused modules:
--   lua/config/options.lua    editor options
--   lua/config/keymaps.lua    global keymaps
--   lua/config/autocmds.lua   autocommands
--   lua/config/pack.lua       plugin manifest (vim.pack) + per-plugin configs
--   lua/config/lsp.lua        LSP servers (vim.lsp.config/enable) + keymaps
--   lua/plugins/mini.lua      autocompletion lives here (mini.completion)
--   lua/config/cheatsheet.lua coding-motions cheatsheet (<leader>m / :Cheatsheet)
--   lua/config/keymap-cheatsheet.lua keybinds/plugins cheatsheet (<leader>k / :Keys)
--   lua/plugins/*.lua         one file per plugin (setup + keymaps)
--
-- Run `:Tutor` if you're new, and `:checkhealth` if something looks off.

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.pack'
require 'config.lsp'
require 'config.cheatsheet'
require 'config.keymap-cheatsheet'

-- The line beneath this is called `modeline`. See `:help modeline`.
-- vim: ts=2 sts=2 sw=2 et
