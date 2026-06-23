-- [[ Autocommands ]]  See `:help lua-guide-autocommands`

-- Briefly highlight yanked text (try it with `yap`).
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Restore a vertical-bar cursor shape on exit (some terminals need this).
vim.api.nvim_create_autocmd('VimLeave', {
  pattern = '*',
  callback = function()
    vim.cmd [[set guicursor=a:ver100]]
  end,
})
