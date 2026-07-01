-- [[ Global keymaps ]]  See `:help vim.keymap.set()`
-- Plugin-specific keymaps live with their plugin under lua/custom/plugins/.

-- Clear search highlight on <Esc>.
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Open the diagnostic quickfix list.
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode with <Esc><Esc>.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Nudge yourself off the arrow keys.
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Move focus between splits with CTRL+<hjkl>.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- ───────────────────────────────────────────────────────────────────────────
-- Quality-of-life keymaps adopted from popular configs (LazyVim, ThePrimeagen).
-- Each block notes WHAT it does and WHY it differs from the default.
-- ───────────────────────────────────────────────────────────────────────────

-- Save with Ctrl-S. `<cmd>…<cr>` runs :write without leaving the current mode,
-- so in insert mode it saves and keeps you typing (no drop back to normal).
vim.keymap.set({ 'n', 'i' }, '<C-s>', '<cmd>write<cr>', { desc = 'Save file' })

-- Alt-j / Alt-k move the current line (normal) or the whole selection (visual)
-- down/up. The trailing `==` / `gv=gv` re-indents the moved text to its new
-- surroundings. Without this you'd be doing dd + p + re-indent by hand.
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move line up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move line down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move selection up' })

-- Keep the cursor centred so you don't lose your place: half-page scrolls
-- re-centre (zz), and jumping between search matches re-centres AND reopens any
-- fold the match is hidden in (zzzv). Default leaves the cursor at screen edges.
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half-page down (centred)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half-page up (centred)' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centred)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev search result (centred)' })

-- In visual mode, keep the selection after shifting indent so you can press
-- < / > repeatedly. Default drops you back to normal mode after one shift.
vim.keymap.set('x', '<', '<gv', { desc = 'Indent left (keep selection)' })
vim.keymap.set('x', '>', '>gv', { desc = 'Indent right (keep selection)' })

-- Paste over a visual selection WITHOUT overwriting your clipboard: the text you
-- replaced is dumped into the black-hole register ("_) instead of the unnamed
-- one, so the thing you copied is still there to paste again.
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste over (keep register)' })

-- Join the line below onto this one but restore the cursor to where it was
-- (mark z) — the default J leaves the cursor sitting at the join seam.
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines (keep cursor)' })

-- Make j/k move by SCREEN line on wrapped lines when used without a count, so
-- long/prose lines feel natural; with a count (e.g. 5j) they stay line-wise so
-- relative-number jumps still land correctly. `expr` lets the rhs be evaluated.
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Down (respect wrap)' })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Up (respect wrap)' })

-- Per-window UI toggles, sitting alongside the plugin toggles in the <leader>u
-- (UI / Toggle) which-key group. `!` flips the boolean option.
vim.keymap.set('n', '<leader>uw', '<cmd>set wrap!<cr>', { desc = 'Toggle word wrap' })
vim.keymap.set('n', '<leader>us', '<cmd>set spell!<cr>', { desc = 'Toggle spell check' })
vim.keymap.set('n', '<leader>u ', '<cmd>set list!<cr>', { desc = 'Toggle show whitespace' })

-- Float the full diagnostic message(s) for the current line (<leader>c = Code),
-- for when the inline virtual text is cut off. (<leader>q still fills the loclist.)
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line diagnostics (float)' })

-- ───────────────────────────────────────────────────────────────────────────
-- Window / split management (<leader>w group + splits), mirroring LazyVim.
-- ───────────────────────────────────────────────────────────────────────────
vim.keymap.set('n', '<leader>-', '<cmd>split<cr>', { desc = 'Split window below' })
vim.keymap.set('n', '<leader>|', '<cmd>vsplit<cr>', { desc = 'Split window right' })
vim.keymap.set('n', '<leader>wd', '<C-w>c', { desc = 'Delete window' })
vim.keymap.set('n', '<leader>wo', '<C-w>o', { desc = 'Close other windows' })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = 'Equalize window sizes' })

-- Resize the current window with Ctrl+<arrows>.
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- ───────────────────────────────────────────────────────────────────────────
-- Floating terminal toggle on <C-/> (many terminals send <C-_> for that chord).
-- ───────────────────────────────────────────────────────────────────────────
local float_term = {}
local function toggle_float_term()
  -- Already open → just hide it.
  if float_term.win and vim.api.nvim_win_is_valid(float_term.win) then
    vim.api.nvim_win_hide(float_term.win)
    float_term.win = nil
    return
  end

  if not (float_term.buf and vim.api.nvim_buf_is_valid(float_term.buf)) then
    float_term.buf = vim.api.nvim_create_buf(false, true)
  end

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  float_term.win = vim.api.nvim_open_win(float_term.buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = 'minimal',
    border = 'rounded',
  })

  -- Spawn the shell only the first time; reuse the same job on later toggles.
  if vim.bo[float_term.buf].buftype ~= 'terminal' then
    vim.fn.jobstart(vim.o.shell, { term = true })
  end
  vim.cmd 'startinsert'
end

vim.keymap.set({ 'n', 't' }, '<C-/>', toggle_float_term, { desc = 'Toggle floating terminal' })
vim.keymap.set({ 'n', 't' }, '<C-_>', toggle_float_term, { desc = 'Toggle floating terminal' })
