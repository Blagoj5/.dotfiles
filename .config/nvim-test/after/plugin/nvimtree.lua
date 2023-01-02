local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

vim.g.root_folder_modifier = ":t"
vim.g.git_hl = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- change color for arrows in tree to light blue
-- vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

nvim_tree.setup({
	actions = {
		open_file = {
			quit_on_open = true,
			window_picker = {
				enable = false,
			},
		},
		-- change_dir = {
		--   enable = false,
		--   global = false,
		--   restrict_above_cwd = true,
		-- }
	},
	update_focused_file = {
		enable = true,
		update_root = false,
		ignore_list = {},
	},
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "", -- arrow when folder is closed
					arrow_open = "", -- arrow when folder is open
				},
			},
		},
	},
	view = {
		adaptive_size = false,
		centralize_selection = false,
		width = "50%",
		hide_root_folder = false,
		side = "left",
		preserve_window_proportions = false,
		number = true,
		relativenumber = true,
		signcolumn = "yes",
		mappings = {
			custom_only = false,
			list = {
				-- user mappings go here
			},
		},
		float = {
			enable = false,
			quit_on_focus_loss = true,
			open_win_config = {
				relative = "editor",
				border = "rounded",
				width = 30,
				height = 30,
				row = 1,
				col = 1,
			},
		},
	},
})

vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeToggle<CR>")
