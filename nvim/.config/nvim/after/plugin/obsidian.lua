require("obsidian").setup({
	ui = { enable = false }, -- markdown.nvim takes care
	workspaces = {
		{
			name = "personal",
			path = "~/vaults/personal",
		},
		{
			name = "work",
			path = "~/vaults/work",
		},
	},
	-- see below for full list of options 👇
	-- Optional, customize how names/IDs for new notes are created.
	note_id_func = function(title)
		-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
		-- In this case a note with the title 'My new note' will be given an ID that looks
		-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
		local suffix = ""
		if title ~= nil then
			-- If title is given, transform it into valid file name.
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		else
			-- If title is nil, just add 4 random uppercase letters to the suffix.
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
		end
		return tostring(os.time()) .. "-" .. suffix
	end,

	-- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
	-- way then set 'mappings = {}'.
	mappings = {
		-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
		["gf"] = {
			action = function()
				return require("obsidian").util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		},
		-- Toggle check-boxes.
		["<leader>ch"] = {
			action = function()
				return require("obsidian").util.toggle_checkbox()
			end,
			opts = { buffer = true },
		},
		-- Smart action depending on context, either follow link or toggle checkbox.
		["<cr>"] = {
			action = function()
				return require("obsidian").util.smart_action()
			end,
			opts = { buffer = true, expr = true },
		},
	},
})

-- vim.keymap.set("n", "gf", function()
-- 	if require("obsidian").util.cursor_on_markdown_link() then
-- 		return vim.cmd.ObsidianFollowLink
-- 	else
-- 		return "gf"
-- 	end
-- end, { noremap = false, expr = true })

vim.keymap.set("n", "<leader>sn", vim.cmd.ObsidianQuickSwitch)
vim.keymap.set("n", "<leader>ns", vim.cmd.ObsidianWorkspace)
vim.keymap.set("n", "<leader>nt", vim.cmd.ObsidianNew)

-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
-- 	pattern = { "gitcommit", "markdown" },
-- 	callback = function()
-- 		vim.opt.conceallevel = 2
-- 	end,
-- })

local concealLevelGroup = vim.api.nvim_create_augroup("conceal_level", { clear = true })
local concealLevelFiles = { "*.txt", "*.md" }

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = concealLevelGroup,
	pattern = concealLevelFiles,
	callback = function()
		vim.opt.conceallevel = 2
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
	group = concealLevelGroup,
	pattern = concealLevelFiles,
	callback = function()
		vim.opt.conceallevel = 0
	end,
})
