function ColorMyPencils(color)
	-- color = color or "gruvbox-material" or "onedark" or "nightfox" or "rose-pine"
	color = color or "rose-pine" or "onedark" or "nightfox" or "rose-pine"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
