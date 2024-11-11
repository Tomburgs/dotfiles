local fn = vim.fn

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Theme
  'ellisonleao/gruvbox.nvim',
  -- UI
  'mkitt/tabline.vim',
  'stevearc/dressing.nvim',
  {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  },
  'folke/zen-mode.nvim',
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      scope = { enabled = false },
    }
  },
  -- Autopairs
  'windwp/nvim-autopairs',
  -- LSP & friends
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp',
  'L3MON4D3/LuaSnip',         -- Snippets
  'saadparwaiz1/cmp_luasnip', -- Make those snippets vibe with cmp
  'onsails/lspkind.nvim',     -- nvim-cmp menu formatting
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  -- Linting
  'mfussenegger/nvim-lint',
  'stevearc/conform.nvim',
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    config = true,
  },
  {
    'xbase-lab/xbase',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    build = 'make install',
  },
  -- Debugging
  'mfussenegger/nvim-dap',
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio'
    }
  },
  {
    'microsoft/vscode-js-debug',
    build = 'rm package-lock.json && yarn --ignore-engines && yarn compile vsDebugServerBundle && mv dist out',
  },
  'mxsdev/nvim-dap-vscode-js',
  {
    'leoluz/nvim-dap-go',
    config = function()
      require('dap-go').setup()
    end,
  },
  {
    'Joakker/lua-json5',
    build = './install.sh'
  },
  -- Searching
  {
    'junegunn/fzf',
    build = function() fn['fzf#install']() end
  },
  'junegunn/fzf.vim',
  {
    'yuki-ycino/fzf-preview.vim',
    branch = 'release/rpc'
  },
  -- Git
  'tpope/vim-fugitive',
  'sheerun/vim-polyglot',
  'preservim/nerdtree',
  'AndrewRadev/tagalong.vim',
  -- Highlighting, although LSP does it as well.
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  -- Lib dep
  'nvim-lua/plenary.nvim',
})

require('settings')
require('keymaps')
require('plugins/lualine')
require('plugins/treesitter')
require('plugins/autopairs')
require('plugins/lspconfig')
require('plugins/dap')
require('plugins/formatting')
require('plugins/cmp')
