-- Keybinds / navigation / plugin-usage cheatsheet.
-- Open with <leader>k or :Keys. Reuses the float renderer from the motions
-- cheatsheet so both look and behave the same.
local cheatsheet = require 'config.cheatsheet'

local M = {}

M.lines = {
  ' Keybinds, navigation & plugins      <leader> = Space     (q / <Esc> close)',
  ' ────────────────────────────────────────────────────────────────────────',
  ' LEADER MENUS — press <leader> then the letter; which-key shows the rest',
  '   e Explorer      f Find files    s Search        c Code',
  '   g Git           h Harpoon       b Buffer        t Tabline (tabs)',
  '   d Debug         x Trouble       u UI toggles    w Window',
  '   q Diag→loclist  m Motions       k This sheet    ? All keymaps',
  '',
  ' FIND  <leader>f                  SEARCH  <leader>s',
  '   ff files                         sg grep (live regex)   sw word under cursor',
  '   fr recent                        sf fuzzy in files      sk keymaps',
  '   fb buffers                       sd diagnostics         sr resume',
  '   fn nvim config                   sh help                s/ lines in buffers',
  '                                    ss doc symbols         sb current buffer',
  '                                    <leader>/  grep (live, project)',
  '',
  ' NAVIGATE',
  '   <C-h/j/k/l>  move between windows',
  '   [b  ]b       prev / next buffer        <A-h> <A-l>  prev / next buffer',
  '   <A-1>..<A-9> jump to buffer N          <leader>tj   pick a buffer',
  '   <leader>1-4  jump to harpoon file 1-4',
  '   <C-d> <C-u>  half-page down/up (centred)',
  '   n  N         next / prev search match (centred)',
  '   ]c [c git hunk   ]t [t todo   ]d [d diagnostic   (next / prev)',
  '',
  ' TABLINE  <leader>t  (the tab bar)',
  '   1-9 go to buffer · 0 last · j pick · [ ] move · p pin',
  '   w close current · x pick-close · o others · h/l close left/right · s/e sort',
  '',
  ' WINDOW  <leader>w',
  '   <leader>- split below · <leader>| split right',
  '   wd close · wo close others · w= equalize · <C-arrows> resize',
  '   <C-/> toggle floating terminal',
  '',
  ' LSP  (inside a code buffer)',
  '   grd definition   grr references    gri implementation   grt type def',
  '   grn rename       gra code action   grs doc symbols      grw workspace',
  '   K hover docs     <leader>cf format     <leader>cd line diagnostic float',
  '',
  ' GIT  <leader>g  (in a tracked file)',
  '   gs stage hunk  gr reset hunk  gp preview  gb blame  gd diff index',
  '   ga stage buf   gx discard buf  gl diff last commit',
  '',
  ' EDIT',
  '   <C-s> save        <A-j>/<A-k> move line/sel       J join (keep cursor)',
  '   <  >  (visual) indent & keep selection',
  '   <leader>p (visual) paste over without losing clipboard',
  '   gcc line comment · gc{motion} comment           (Comment.nvim)',
  '   sa{motion}{c} add · sd{c} delete · sr{old}{new} replace   (surround)',
  '   vif/vaf function · vic/vac class · vio/vao block  (text objects)',
  '',
  ' UI TOGGLES  <leader>u',
  '   ub blame · uc context · ud deleted · uh inlay hints',
  '   ui indent guides · ul lsp · uw wrap · us spell',
  '',
  ' PLUGINS — quick usage',
  '   neo-tree (<leader>e):  a add · d delete · r rename · c copy · x cut · p paste',
  '   fzf-lua picker:        type to filter · <Tab> multi-select · <C-q> → quickfix',
  '   trouble (<leader>x):   <CR> jump to item · q close',
  '   todo-comments:         <leader>xt list in Trouble · ]t [t jump',
  '',
  ' See also: <leader>m for the coding-motions cheatsheet.',
}

function M.open()
  cheatsheet.open_float(M.lines, ' Keybinds & navigation ')
end

vim.api.nvim_create_user_command('Keys', M.open, { desc = 'Keybinds / navigation / plugin cheatsheet' })
vim.keymap.set('n', '<leader>k', M.open, { desc = '[k]eybinds cheatsheet' })

return M
