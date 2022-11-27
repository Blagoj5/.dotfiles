local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print('Installing packer...')
    local packer_url = 'https://github.com/wbthomason/packer.nvim'
    vim.fn.system({ 'git', 'clone', '--depth', '1', packer_url, install_path })
    print('Done.')

    vim.cmd('packadd packer.nvim')
    install_plugins = true
end

require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Theme inspired by Atom
    use 'joshdick/onedark.vim'
    use 'folke/tokyonight.nvim'

    use 'nvim-lualine/lualine.nvim'

    -- Telescope
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    use { 'lewis6991/gitsigns.nvim' -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use 'nvim-treesitter/nvim-treesitter-context'

    use 'nvim-tree/nvim-web-devicons'
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' -- optional, for file icons
        },
        tag = 'nightly'
    }

    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    })
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    use 'kylechui/nvim-surround'

    -- registers
    -- https://github.com/gennaro-tedesco/nvim-peekup

    -- marks
    -- https://github.com/chentoast/marks.nvim

    use 'numToStr/Comment.nvim'

    use 'windwp/nvim-autopairs'

    -- add for notes

    use 'folke/zen-mode.nvim'

    -- Debugging
    -- https://github.com/mfussenegger/nvim-dap
    -- https://github.com/David-Kunz/jester

    -- https://github.com/NvChad/nvim-colorizer.lua
end)


if install_plugins then
    print '=================================='
    print '    Plugins will be installed.'
    print '      After you press Enter'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end
