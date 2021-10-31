local cmd = vim.cmd
local fn = vim.fn

cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'windwp/nvim-autopairs'
  use 'ray-x/lsp_signature.nvim'
  use {
    'junegunn/fzf.vim',
    requires = {'junegunn/fzf', run = function() fn['fzf#install']() end }
  }
  use 'tpope/vim-fugitive'
  use 'preservim/nerdtree'
  use 'mkitt/tabline.vim'
  use 'AndrewRadev/tagalong.vim'
  use 'glepnir/dashboard-nvim'
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/plenary.nvim'}
  }  
  use {
    'ms-jpq/coq_nvim', branch = 'coq'
  }
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }
end)
