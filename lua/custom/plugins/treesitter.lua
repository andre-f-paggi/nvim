-- Accurate, language-aware syntax highlighting, indentation and folding.
-- See `:help nvim-treesitter`.
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
    auto_install = true, -- install parsers for new filetypes on the fly
    highlight = {
      enable = true,
      -- Some languages (e.g. Ruby) need Vim's regex highlighting for indents.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
  config = function(_, opts)
    -- Use zig as the C compiler when building parsers (Windows-friendly).
    require('nvim-treesitter.install').compilers = { 'zig' }
    require('nvim-treesitter.configs').setup(opts)
  end,
}
