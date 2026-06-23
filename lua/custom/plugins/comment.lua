-- Smart commenting. Keymaps (all dot-repeatable):
--   gcc      toggle the current line
--   gc{motion}  e.g. gcap (comment a paragraph), gcj (this line + next)
--   gc       in Visual mode, toggle the selection
--   gbc      toggle a block comment
-- (Modern Neovim has a native gc, but Comment.nvim adds treesitter awareness.)
return {
  'numToStr/Comment.nvim',
  opts = {},
}
