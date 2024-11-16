vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  -- Plugin Manager --
  use 'wbthomason/packer.nvim'

  -- Color Schemes --
  use 'rebelot/kanagawa.nvim'

  use 'jackhogg97/nvim-hardline'
  use ({'nvim-treesitter/nvim-treesitter'}, {run = ':TSUpdate'})
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'tpope/vim-fugitive'

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  }

  use {
    'nvim-telescope/telescope.nvim',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  use { 'mattn/vim-gist',
    requires = { {'mattn/webapi-vim'} }
  }

  use 'alexghergh/nvim-tmux-navigation'

end)
