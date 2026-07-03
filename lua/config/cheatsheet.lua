-- Coding-motions cheatsheet: a floating "menu" of the most useful selection and
-- editing motions for coding. Open it with <leader>m or :Cheatsheet.
-- The generic float renderer (M.open_float) is shared with the keybinds
-- cheatsheet in config/keymap-cheatsheet.lua.
local M = {}

-- Render a list of display lines in a centred, scrollable floating window.
-- Reused by both cheatsheets so the look/behaviour stays consistent.
function M.open_float(lines, title)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = 'wipe'

  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end
  width = math.min(width + 2, vim.o.columns - 4)
  local height = math.min(#lines, vim.o.lines - 4)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2 - 1),
    col = math.floor((vim.o.columns - width) / 2),
    style = 'minimal',
    border = 'rounded',
    title = title,
    title_pos = 'center',
  })
  vim.wo[win].cursorline = true

  -- Close with q or <Esc>.
  for _, key in ipairs { 'q', '<Esc>' } do
    vim.keymap.set('n', key, '<cmd>close<cr>', { buffer = buf, nowait = true, silent = true })
  end
end

M.lines = {
  ' Coding motions — common selections & edits          (q / <Esc> to close)',
  ' ───────────────────────────────────────────────────────────────────────',
  ' Operators:  v select   d delete   c change   y yank   x del char',
  ' Combine an operator with a text object below, e.g.  vif   ci(   daf   yi{',
  ' NOTE: d / D / x delete to the black-hole register (no yank). y is the only',
  '       fill; use <leader>dd for a classic cut (delete INTO the register).',
  '',
  ' TEXT OBJECTS        i = INSIDE        a = AROUND (includes the delimiters)',
  '   i(  a(            parentheses ( )   — also the args of a call',
  '   i{  a{            braces { }        — a code block body',
  '   i[  a[            brackets [ ]      — arrays / indexers',
  [[   i"  a"  i'  i`    quotes]],
  '   it  at            HTML / XML tag',
  '   iw  aw            word     (iW aW = WORD, includes punctuation)',
  '   ip  ap            paragraph',
  '   if  af            whole FUNCTION    (treesitter)',
  '   ic  ac            whole CLASS       (treesitter)',
  '   io  ao            if / loop block   (treesitter)',
  '',
  ' EXAMPLES',
  '   vif  select whole function        daf  delete whole function',
  [[   ci(  change inside parens          ci"  change inside quotes]],
  '   yi{  yank inside braces            cit  change inside tag',
  '   ciw  change word                   vi[  select inside brackets',
  '   va{  select braces + contents      %    jump to matching bracket',
  '',
  ' SURROUND (mini.surround)',
  '   sa{motion}{char}  add      e.g.  saiw)  wrap word in ( )',
  [[   sd{char}          delete   e.g.  sd"    remove quotes]],
  '   sr{old}{new}      replace  e.g.  sr({   change ( ) to { }',
  '',
  ' COMMENT (Comment.nvim)              CODE NAV',
  '   gcc          toggle line          ]m [m   next / prev method',
  '   gc{motion}   toggle motion        grd     go to definition',
  '   gc (visual)  toggle selection     grr     references',
  '',
  ' Tip: <leader>k = keybinds / plugin cheatsheet · <leader>? = every mapping.',
}

function M.open()
  M.open_float(M.lines, ' Coding motions ')
end

vim.api.nvim_create_user_command('Cheatsheet', M.open, { desc = 'Coding motions cheatsheet' })
vim.keymap.set('n', '<leader>m', M.open, { desc = 'Coding [m]otions cheatsheet' })

return M
