local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim'

    -- Theme inspired by Atom
    -- use 'joshdick/onedark.vim'
    -- use 'folke/tokyonight.nvim'
    use { "ellisonleao/gruvbox.nvim" }

    -- use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

    use 'nvim-lualine/lualine.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { 'lewis6991/gitsigns.nvim' }

    use 'nvim-tree/nvim-web-devicons'
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' -- optional, for file icons
        },
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use 'nvim-treesitter/nvim-treesitter-context'


    -- autocompletion
    use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion
    use("hrsh7th/nvim-cmp") -- completion plugin
    use("hrsh7th/cmp-buffer") -- source for text in buffer
    use("hrsh7th/cmp-path") -- source for file system paths

    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    })
    use 'hrsh7th/cmp-nvim-lsp'
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
    
    use {"ellisonleao/glow.nvim"}

    if packer_bootstrap then
      require("packer").sync()
    end
end)
