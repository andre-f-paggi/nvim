-- Treesitter ('main' branch API): accurate syntax highlighting + indentation.
-- A base set is installed up front; any other language installs itself the
-- first time you open a matching file, then highlighting starts automatically.
local ts = require 'nvim-treesitter'

-- Windows-friendly compiler fallback: use zig when no cc/gcc/clang is around.
if vim.fn.executable 'cc' == 0 and vim.fn.executable 'gcc' == 0 and vim.fn.executable 'clang' == 0 and vim.fn.executable 'zig' == 1 then
  vim.env.CC = 'zig cc'
end

-- Base parsers installed eagerly so the common languages are ready immediately.
ts.install {
  'bash',
  'c',
  'c_sharp',
  'diff',
  'git_config',
  'git_rebase',
  'gitcommit',
  'gitattributes',
  'go',
  'html',
  'javascript',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'powershell',
  'python',
  'query',
  'ruby',
  'rust',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

-- Start highlighting + treesitter indentation for any buffer whose filetype
-- resolves to a parser. If the parser isn't installed yet but is available,
-- install it on the fly and start once it lands. `installing` guards against
-- kicking off the same install twice while it's in flight.
local installing = {}

local function enable(buf, lang)
  if not pcall(vim.treesitter.language.add, lang) then
    return
  end
  pcall(vim.treesitter.start, buf, lang)
  if lang ~= 'ruby' then
    -- Ruby indents better with Vim's regex engine; everything else with TS.
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('config-treesitter-start', { clear = true }),
  callback = function(args)
    local buf = args.buf
    local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
    if not lang or not vim.tbl_contains(ts.get_available(), lang) then
      return
    end

    if vim.tbl_contains(ts.get_installed 'parsers', lang) then
      enable(buf, lang)
    elseif not installing[lang] then
      installing[lang] = true
      ts.install(lang):await(vim.schedule_wrap(function()
        installing[lang] = nil
        if vim.api.nvim_buf_is_valid(buf) then
          enable(buf, lang)
        end
      end))
    end
  end,
})
