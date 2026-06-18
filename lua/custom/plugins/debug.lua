-- Debugging: nvim-dap (engine) + nvim-dap-ui (graphical UI), wired up for C#/.NET.
--
-- First-time setup:
--   1) Restart nvim so lazy.nvim installs the plugins.
--   2) `:MasonInstall netcoredbg` (or let mason-nvim-dap auto-install it).
--   3) Build your project, then press <F5> and point it at your .dll.
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio', -- required by nvim-dap-ui
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim', -- installs debug adapters via Mason
  },
  keys = {
    { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
    { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
    { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
    { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    { '<leader>dc', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: [c]onditional Breakpoint' },
    { '<leader>du', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
    { '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Debug: Toggle REPL' },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = { 'netcoredbg' }, -- the .NET debugger
    }

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Open/close the UI automatically with the debug session.
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- C#/.NET adapter (netcoredbg, installed above via Mason).
    dap.adapters.coreclr = {
      type = 'executable',
      command = vim.fn.exepath 'netcoredbg',
      args = { '--interpreter=vscode' },
    }
    dap.configurations.cs = {
      {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
      },
    }
  end,
}
