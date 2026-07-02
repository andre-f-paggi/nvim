-- [[ Plugin manifest — vim.pack ]]  See `:help vim.pack`
-- Every plugin this config uses, in one list. `vim.pack.add` clones anything
-- missing into stdpath('data')/site/pack/core and puts it on the runtimepath.
-- Update with `vim.pack.update()`; remove leftovers with `vim.pack.del`.

local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add {
  -- Colorscheme (added first so UI plugins pick it up).
  gh 'kepano/flexoki-neovim',

  -- Shared libraries.
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-tree/nvim-web-devicons',
  gh 'MunifTanjim/nui.nvim',

  -- Treesitter ('main' is the maintained rewrite; 'master' is frozen).
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = gh 'nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  gh 'nvim-treesitter/nvim-treesitter-context',

  -- LSP: ready-made server configs + binary installer + status UI.
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'j-hui/fidget.nvim',
  gh 'folke/lazydev.nvim',
  gh 'seblyng/roslyn.nvim',

  -- Formatting.
  gh 'stevearc/conform.nvim',

  -- Debugging.
  gh 'mfussenegger/nvim-dap',
  gh 'rcarriga/nvim-dap-ui',
  gh 'nvim-neotest/nvim-nio',

  -- Editor / UI.
  gh 'ibhagwan/fzf-lua',
  { src = gh 'ThePrimeagen/harpoon', version = 'harpoon2' },
  { src = gh 'nvim-neo-tree/neo-tree.nvim', version = 'v3.x' },
  gh 'lewis6991/gitsigns.nvim',
  gh 'nvim-lualine/lualine.nvim',
  gh 'akinsho/bufferline.nvim',
  gh 'folke/which-key.nvim',
  gh 'echasnovski/mini.nvim',
  gh 'folke/todo-comments.nvim',
  gh 'folke/trouble.nvim',
  gh 'numToStr/Comment.nvim',
  gh 'NMAC427/guess-indent.nvim',
  gh 'lukas-reineke/indent-blankline.nvim',
  gh 'ThePrimeagen/vim-be-good',
}

-- Rebuild treesitter parsers whenever the plugin itself is updated
-- (replaces lazy.nvim's `build = ':TSUpdate'`).
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('pack-ts-update', { clear = true }),
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      vim.schedule(function()
        vim.cmd 'TSUpdate'
      end)
    end
  end,
})

-- Per-plugin configuration, one file each under lua/plugins/.
-- Mason comes first so its bin dir is on PATH before anything resolves tools.
local modules = {
  'colorscheme',
  'mason',
  'treesitter',
  'treesitter-context',
  'fidget',
  'lazydev',
  'roslyn',
  'conform',
  'dap',
  'fzf-lua',
  'harpoon',
  'neo-tree',
  'gitsigns',
  'lualine',
  'bufferline',
  'which-key',
  'mini',
  'todo-comments',
  'trouble',
  'comment',
  'guess-indent',
  'indent-blankline',
}

for _, mod in ipairs(modules) do
  require('plugins.' .. mod)
end
