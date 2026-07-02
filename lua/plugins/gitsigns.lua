-- Git change signs in the gutter (+ / ~ / _) plus hunk actions.
-- Keymaps are buffer-local (only active in git-tracked files) and grouped under
-- <leader>g (Git) and <leader>u (UI/Toggle). All lowercase — no Shift needed.
-- See `:help gitsigns`.
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation between changed hunks
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git [c]hange' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git [c]hange' })

    -- Actions ([G]it)
    map('v', '<leader>gs', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'git [s]tage selection' })
    map('v', '<leader>gr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'git [r]eset selection' })
    map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
    map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
    map('n', '<leader>ga', gitsigns.stage_buffer, { desc = 'git st[a]ge buffer' })
    map('n', '<leader>gx', gitsigns.reset_buffer, { desc = 'git reset buffer (discard)' })
    map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
    map('n', '<leader>gb', gitsigns.blame_line, { desc = 'git [b]lame line' })
    map('n', '<leader>gd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    map('n', '<leader>gl', function()
      gitsigns.diffthis '@'
    end, { desc = 'git diff against [l]ast commit' })

    -- Toggles (UI/Toggle group)
    map('n', '<leader>ub', '<cmd>Gitsigns toggle_current_line_blame<cr>', { desc = 'Toggle git [b]lame line' })
    map('n', '<leader>ud', '<cmd>Gitsigns toggle_deleted<cr>', { desc = 'Toggle git show [d]eleted' })
  end,
}
