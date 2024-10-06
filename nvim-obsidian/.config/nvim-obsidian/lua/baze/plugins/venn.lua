return {
	"jbyuki/venn.nvim",
	config = function(_, opts)
		-- require("jbyuki/venn.nvim").setup(opts)
		-- Toggle venn key mappings
		function _G.Toggle_venn()
			local venn_enabled = vim.inspect(vim.b.venn_enabled)
			if venn_enabled == "nil" then
				vim.b.venn_enabled = true
				vim.cmd([[setlocal ve=all]])
				-- Draw a line with HJKL keys
				vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true, silent = true })
				vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true, silent = true })
				-- Draw a box by pressing "f" in visual mode
				vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true, silent = true })
			else
				-- Disable venn mappings
				vim.cmd([[setlocal ve=]])
				vim.api.nvim_buf_del_keymap(0, "n", "J")
				vim.api.nvim_buf_del_keymap(0, "n", "K")
				vim.api.nvim_buf_del_keymap(0, "n", "L")
				vim.api.nvim_buf_del_keymap(0, "n", "H")
				vim.api.nvim_buf_del_keymap(0, "v", "f")
				vim.b.venn_enabled = nil
			end
		end

		-- toggle keymappings for venn using <leader>v
		vim.api.nvim_set_keymap("n", "<leader>v", ":lua Toggle_venn()<CR>", { noremap = true })
	end,
}
