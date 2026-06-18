-- Shows a popup of possible follow-up keys after you start a keybinding.
-- The `spec` below is the single source of truth for the leader-menu CATEGORIES;
-- each individual mapping's label lives with its plugin (its `desc`).
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  keys = {
    {
      '<leader>?',
      '<cmd>WhichKey<cr>',
      desc = 'Show all keymaps (which-key)',
    },
  },
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },

    -- [[ Leader-menu categories ]] — one group per plugin / concern.
    spec = {
      { '<leader>s', group = '[S]earch (Telescope)' },
      { '<leader>z', group = 'Find (fzf-lua)' },
      { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
      { '<leader>h', group = '[H]arpoon' },
      { '<leader>b', group = '[B]uffer' },
      { '<leader>d', group = '[D]ebug' },
      { '<leader>x', group = '[X] Diagnostics (Trouble)' },
      { '<leader>t', group = '[T]oggle' },
      -- Buffer-local LSP actions (active when a language server attaches).
      { 'gr', group = '[G]oto / LSP', mode = { 'n', 'x' } },
    },
  },
}
