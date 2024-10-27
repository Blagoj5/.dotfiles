return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",

					["<C-c>"] = "close",

					["<Down>"] = "move_selection_next",
					["<Up>"] = "move_selection_previous",

					["<C-u>"] = "preview_scrolling_up",
					["<C-d>"] = "preview_scrolling_down",
				},

				n = {
					["<esc>"] = "close",
					["<C-c>"] = "close",
					-- 	["<Tab>"] = require("telescope.actions").toggle_selection + actions.move_selection_worse,
					-- 	["<S-Tab>"] = require("telescope.actions").toggle_selection + actions.move_selection_better,
					-- 	["j"] = require("telescope.actions").move_selection_next,
					-- 	["k"] = require("telescope.actions").move_selection_previous,
					-- 	["H"] = require("telescope.actions").move_to_top,
					-- 	["M"] = require("telescope.actions").move_to_middle,
					-- 	["L"] = require("telescope.actions").move_to_bottom,
					["<Down>"] = "move_selection_next",
					["<Up>"] = "move_selection_previous",
					["gg"] = "move_to_top",
					["G"] = "move_to_bottom",
					["<C-u>"] = "preview_scrolling_up",
					["<C-d>"] = "preview_scrolling_down",
				},
			},
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		pcall(require("telescope").load_extension, "fzf")

		-- See `:help telescope.builtin`
		vim.keymap.set(
			"n",
			"<leader>?",
			require("telescope.builtin").oldfiles,
			{ desc = "[?] Find recently opened files" }
		)

		vim.keymap.set(
			"n",
			"<leader><space>",
			require("telescope.builtin").buffers,
			{ desc = "[ ] Find existing buffers" }
		)

		vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set(
			"n",
			"<leader>sw",
			require("telescope.builtin").grep_string,
			{ desc = "[S]earch current [W]ord" }
		)
		vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
	end,
}
