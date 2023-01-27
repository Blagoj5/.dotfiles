require("lualine").setup({
	options = {
		globalstatus = true,
		icons_enabled = false,
		theme = "auto",
		component_separators = "|",
		section_separators = "",
		disabled_filetypes = {
			statusline = {},
			winbar = {
				"NvimTree",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {},
		lualine_x = { "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = {},
	},
	winbar = {
		lualine_a = {},
		lualine_b = { "%f %m" },
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	iactive_winbar = {
		lualine_a = {},
		lualine_b = { "%f %m" },
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
})
