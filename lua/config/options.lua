-- [[ Editor options ]]  See `:help vim.o` and `:help option-list`

-- Line numbers: show BOTH the absolute number and the relative distance on
-- every line via a custom gutter. (number/relativenumber stay on so v:lnum and
-- v:relnum behave as expected.)
vim.o.number = true
vim.o.relativenumber = true
vim.opt.statuscolumn = '%s %{v:lnum} %=%{v:relnum} '

-- Enable mouse mode (handy for resizing splits).
vim.o.mouse = 'a'

-- Don't show the mode; the statusline already shows it.
vim.o.showmode = false

-- Sync clipboard with the OS (scheduled to keep startup fast).
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true -- keep indentation when wrapping long lines

-- Persistent undo/backup/swap, centralized under stdpath('state') instead of the default
-- fallback — if that target dir is ever missing, Neovim silently drops "<file>.un~"/"<file>~"
-- right next to whatever's being edited (that's how stray files ended up in deploy/ dirs).
-- mkdir -p guarantees these exist before undofile/backup ever get a chance to fall back.
vim.o.undofile = true -- persistent undo history across sessions
local state_dir = vim.fn.stdpath 'state'
for _, sub in ipairs { 'undo', 'backup', 'swap' } do
  vim.fn.mkdir(state_dir .. '/' .. sub, 'p')
end
vim.o.undodir = state_dir .. '/undo//'
vim.o.backupdir = state_dir .. '/backup//'
vim.o.directory = state_dir .. '/swap//'

-- Case-insensitive search unless the query has capitals or \C.
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes' -- always show the sign column
vim.o.updatetime = 250 -- faster CursorHold events
vim.o.timeoutlen = 300 -- mapped-sequence wait time (ms)

-- Open new splits to the right / below.
vim.o.splitright = true
vim.o.splitbelow = true

-- Show whitespace characters.
vim.o.list = true
vim.opt.listchars = { tab = '⇤–⇥', trail = '·', nbsp = 'x', space = '·', precedes = '⇠', extends = '⇢' }

vim.o.inccommand = 'split' -- live preview of :substitute
vim.o.cursorline = true -- highlight the current line
vim.o.scrolloff = 10 -- keep 10 lines visible around the cursor
vim.o.confirm = true -- ask to save instead of failing :q

-- [[ Windows: use PowerShell for :terminal and :! ]]
vim.o.shell = 'pwsh.exe'
vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command $PSStyle.OutputRendering = 'PlainText';"
vim.o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
vim.o.shellquote = ''
vim.o.shellxquote = ''
