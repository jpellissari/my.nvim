-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  })

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('folke/which-key.nvim')
  use('lewis6991/gitsigns.nvim')
  use('lukas-reineke/indent-blankline.nvim')

  use {
    'folke/trouble.nvim',
    requires = {
      { 'nvim-tree/nvim-web-devicons' }
    }
  }

  use { 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {
    "epwalsh/obsidian.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
      { 'folke/neodev.nvim' },

      { 'jose-elias-alvarez/null-ls.nvim' }
    }
  }
end)
