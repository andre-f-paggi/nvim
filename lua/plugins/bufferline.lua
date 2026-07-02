-- Buffer tabs along the top, like VS Code.
-- The general buffer op (delete) stays under <leader>b; everything that drives
-- the tab bar lives under its own <leader>t (Tabline) menu. Cycle with [b / ]b,
-- or jump instantly with <A-1>..<A-9> / <A-h> / <A-l>.
require('bufferline').setup {
  options = {
    diagnostics = 'nvim_lsp', -- show LSP errors/warnings on each tab
    always_show_bufferline = false, -- hide when only one buffer is open
    -- Route the tab "x" button, pick-close and middle-click through
    -- mini.bufremove so closing a tab preserves the window/layout (and
    -- doesn't close Neovim) instead of the default `bdelete`.
    close_command = function(bufnr)
      require('mini.bufremove').delete(bufnr, false)
    end,
    right_mouse_command = function(bufnr)
      require('mini.bufremove').delete(bufnr, false)
    end,
  },
}

local map = vim.keymap.set

-- General buffer (kept under <leader>b). mini.bufremove keeps the window
-- (and Neovim) open instead of closing it when this is the last buffer.
map('n', '<leader>bw', function()
  require('mini.bufremove').delete(0, false)
end, { desc = 'Close buffer (keep layout)' })

-- Cycle prev/next (no leader — ergonomic)
map('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer' })
map('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
map('n', '<A-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer' })
map('n', '<A-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })

-- Tabline menu — navigate
map('n', '<leader>tj', '<cmd>BufferLinePick<cr>', { desc = 'Pick buffer (jump)' })
map('n', '<leader>t0', '<cmd>BufferLineGoToBuffer -1<cr>', { desc = 'Go to last buffer' })

-- Tabline menu — move / reorder
map('n', '<leader>t[', '<cmd>BufferLineMovePrev<cr>', { desc = 'Move buffer left' })
map('n', '<leader>t]', '<cmd>BufferLineMoveNext<cr>', { desc = 'Move buffer right' })

-- Tabline menu — pin
map('n', '<leader>tp', '<cmd>BufferLineTogglePin<cr>', { desc = 'Toggle pin' })

-- Tabline menu — close
map('n', '<leader>tw', function()
  require('mini.bufremove').delete(0, false)
end, { desc = 'Close current buffer (keep layout)' })
map('n', '<leader>tx', '<cmd>BufferLinePickClose<cr>', { desc = 'Pick buffer to close' })
map('n', '<leader>to', '<cmd>BufferLineCloseOthers<cr>', { desc = 'Close other buffers' })
map('n', '<leader>th', '<cmd>BufferLineCloseLeft<cr>', { desc = 'Close buffers to the left' })
map('n', '<leader>tl', '<cmd>BufferLineCloseRight<cr>', { desc = 'Close buffers to the right' })

-- Tabline menu — sort
map('n', '<leader>ts', '<cmd>BufferLineSortByDirectory<cr>', { desc = 'Sort by directory' })
map('n', '<leader>te', '<cmd>BufferLineSortByExtension<cr>', { desc = 'Sort by extension' })

-- Go to buffer N: <leader>t1..t9 (discoverable in the menu) and <A-1>..<A-9> (instant).
for i = 1, 9 do
  map('n', '<leader>t' .. i, '<cmd>BufferLineGoToBuffer ' .. i .. '<cr>', { desc = 'Go to buffer ' .. i })
  map('n', '<A-' .. i .. '>', '<cmd>BufferLineGoToBuffer ' .. i .. '<cr>', { desc = 'Go to buffer ' .. i })
end
