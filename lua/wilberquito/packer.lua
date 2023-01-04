local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
    vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function()
    -- Packer just manages itself
    use 'wbthomason/packer.nvim'

    -- LSP and completion
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    -- LSP renaming with inmediate visual feedback
    use {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
        end,
    }

    ----------------
    -- Plugin development
    ----------------

    -- remember cursor last place
    use 'ethanholz/nvim-lastplace'

    use { "ellisonleao/gruvbox.nvim" }

    -- Rose pine color theme
    use { 'rose-pine/neovim', as = 'rose-pine' }

    -- Catppuccin theme
    use { "catppuccin/nvim", as = "catppuccin" }

    -- Treesitter is life
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use 'nvim-treesitter/playground'

    -- Gaze deeply into the unknown
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Use fzf native for telescope
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- nvim file tree. Alternative to NerdTree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = function() require 'nvim-tree'.setup {} end
    }

    -- Git stuff
    use 'airblade/vim-gitgutter'

    -- comment stuff out
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use 'github/copilot.vim'

    use 'folke/zen-mode.nvim'

    -- Time Pope is a god
    use 'tpope/vim-surround'
    use 'tpope/vim-fugitive'

    -- Yanking manager (yeah yeah I know, registers exist)
    use {
        "AckslD/nvim-neoclip.lua",
        requires = { { 'nvim-telescope/telescope.nvim' } },
        config = function()
            require('neoclip').setup()
        end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require 'alpha'.setup(require 'alpha.themes.theta'.config)
        end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
