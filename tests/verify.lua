-- Headless config verification. Run from the repo root (as the active config):
--
--   nvim --headless "+luafile tests/verify.lua"
--
-- Levels (VERIFY_LEVEL env var, default 3; each level includes the previous):
--   1  clean start — no errors in :messages after startup
--   2  :checkhealth vim.lsp + nvim-treesitter contain no ERROR lines
--   3  open one fixture per language, assert the LSP server attaches and
--      advertises completion (servers must be installed, see :Mason)
--
-- Exit code: 0 on success, 1 on any failure (CI-friendly).

local level = tonumber(vim.env.VERIFY_LEVEL or '3') or 3
local failures, skips = {}, {}

local function log(msg)
  io.write(msg .. '\n')
end

local function fail(msg)
  table.insert(failures, msg)
  log('  FAIL  ' .. msg)
end

local function ok(msg)
  log('  ok    ' .. msg)
end

-- ── Level 1: clean startup ──────────────────────────────────────────────────
log '── L1: clean startup ──'
local messages = vim.api.nvim_exec2('messages', { output = true }).output
if messages:find 'E%d+' or messages:lower():find 'error' then
  fail('startup produced error messages:\n' .. messages)
else
  ok 'no error messages on startup'
end

-- ── Level 2: checkhealth ────────────────────────────────────────────────────
if level >= 2 then
  log '── L2: checkhealth ──'
  for _, mod in ipairs { 'vim.lsp', 'nvim-treesitter' } do
    local health_ok, err = pcall(vim.cmd, 'silent checkhealth ' .. mod)
    if not health_ok then
      fail('checkhealth ' .. mod .. ' failed to run: ' .. tostring(err))
    else
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local errors = vim.tbl_filter(function(l)
        return l:find '%- ERROR'
      end, lines)
      if #errors > 0 then
        fail('checkhealth ' .. mod .. ': ' .. table.concat(errors, ' | '))
      else
        ok('checkhealth ' .. mod .. ' has no ERRORs')
      end
      vim.cmd 'bwipeout!'
    end
  end
end

-- ── Level 3: per-language LSP attach + completion capability ────────────────
if level >= 3 then
  log '── L3: LSP attach per language ──'
  local fixtures = vim.fs.joinpath(vim.fn.stdpath 'config', 'tests', 'fixtures')

  ---@type { file: string, server: string, timeout: integer?, optional: boolean? }[]
  local langs = {
    { file = 'sample.lua', server = 'lua_ls' },
    { file = 'sample.ts', server = 'ts_ls' },
    { file = 'sample.sh', server = 'bashls' },
    { file = 'sample.json', server = 'jsonls' },
    { file = 'sample.yaml', server = 'yamlls' },
    { file = 'sample.md', server = 'marksman' },
    { file = 'sample.py', server = 'basedpyright' },
    { file = 'sample.rb', server = 'ruby_lsp', timeout = 60000 },
    { file = 'rust/src/main.rs', server = 'rust_analyzer', timeout = 60000 },
    { file = 'go/main.go', server = 'gopls', timeout = 60000 },
    -- PSES and Roslyn are heavyweight; Roslyn also needs solution/project
    -- discovery, so treat both as best-effort rather than hard failures.
    { file = 'sample.ps1', server = 'powershell_es', timeout = 120000, optional = true },
    { file = 'cs/Program.cs', server = 'roslyn', timeout = 120000, optional = true },
  }

  for _, lang in ipairs(langs) do
    local path = vim.fs.joinpath(fixtures, lang.file)
    vim.cmd.edit(vim.fn.fnameescape(path))
    local bufnr = vim.api.nvim_get_current_buf()

    local attached = vim.wait(lang.timeout or 30000, function()
      for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
        if client.name == lang.server and client.initialized then
          return true
        end
      end
      return false
    end, 250)

    if not attached then
      if lang.optional then
        table.insert(skips, lang.server)
        log('  skip  ' .. lang.server .. ' did not attach to ' .. lang.file .. ' (optional)')
      else
        fail(lang.server .. ' did not attach to ' .. lang.file)
      end
    else
      local client = vim.lsp.get_clients({ bufnr = bufnr, name = lang.server })[1]
      if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion, bufnr) then
        ok(lang.server .. ' attached with completion (' .. lang.file .. ')')
      else
        fail(lang.server .. ' attached but does not advertise completion')
      end
    end
  end
end

-- ── Summary ─────────────────────────────────────────────────────────────────
log '────────────────────────'
if #skips > 0 then
  log('skipped (optional): ' .. table.concat(skips, ', '))
end
if #failures > 0 then
  log(('FAILED: %d problem(s)'):format(#failures))
  vim.cmd 'cquit!'
else
  log 'PASSED'
  vim.cmd 'qall!'
end
