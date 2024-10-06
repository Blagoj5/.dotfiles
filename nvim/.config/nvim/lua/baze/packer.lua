-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Fuzzy Finder (files, lsp, etc)
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })
	use({
		"laytan/tailwind-sorter.nvim",
		requires = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		config = function()
			require("tailwind-sorter").setup()
		end,
		run = "cd formatter && npm ci && npm run build",
	})

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-context")
	use({
		-- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})

	-- use('nvim-treesitter/playground')
	use("theprimeagen/harpoon")
	use("mbbill/undotree")

	-- git stuff
	use("tpope/vim-fugitive")
	use({
		"lewis6991/gitsigns.nvim",
		-- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
	})
	use("ThePrimeagen/git-worktree.nvim")

	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "jose-elias-alvarez/typescript.nvim" }, -- additional functionality for typescript server (e.g. rename file & update imports)

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "jayp0521/mason-null-ls.nvim" }, -- bridges gap b/w mason & null-ls

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	use("folke/zen-mode.nvim")
	-- use("github/copilot.vim")

	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines
	use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically

	use("folke/neodev.nvim")

	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	use("kylechui/nvim-surround")

	-- debug/tests plugins
	-- use("David-Kunz/jester")
	use({
		"mfussenegger/nvim-dap",
		requires = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
	})
	use("nvim-telescope/telescope-dap.nvim")
	use("vim-test/vim-test")
	use({
		"andrewferrier/debugprint.nvim",
		config = function()
			require("debugprint").setup()
		end,
	})

	use({
		"nvim-neotest/neotest",
		requires = {
			-- Your test adapters here
			"fredrikaverpil/neotest-golang", -- Installation
			"nvim-neotest/neotest-jest",
			"thenbe/neotest-playwright",
		},
	})

	use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	})

	-- use({
	-- 	"iamcco/markdown-preview.nvim",
	-- 	run = "cd app && npm install",
	-- 	setup = function()
	-- 		vim.g.mkdp_filetypes = { "markdown" }
	-- 	end,
	-- 	ft = { "markdown" },
	-- })
	use({
		"ellisonleao/glow.nvim",
		config = function()
			require("glow").setup()
		end,
	})
	use("wittyjudge/gruvbox-material.nvim")

	use({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	})
	use("EdenEast/nightfox.nvim")
	use("navarasu/onedark.nvim")
	use("marko-cerovac/material.nvim")

	use({
		"epwalsh/obsidian.nvim",
		tag = "*", -- recommended, use latest release instead of latest commit
		requires = {
			-- Required.
			"nvim-lua/plenary.nvim",
			-- see below for full list of optional dependencies 👇
		},
	})
	-- use("echasnovski/mini.nvim")
	-- use("echasnovski/mini.icons")
	use({
		"MeanderingProgrammer/markdown.nvim",
		as = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
		after = { "nvim-treesitter" },
		-- requires = { "echasnovski/mini.nvim", opt = true }, -- if you use the mini.nvim suite
		-- requires = { "echasnovski/mini.icons", opt = true }, -- if you use standalone mini plugins
		requires = { "nvim-tree/nvim-web-devicons", opt = true }, -- if you prefer nvim-web-devicons
	})
end)
