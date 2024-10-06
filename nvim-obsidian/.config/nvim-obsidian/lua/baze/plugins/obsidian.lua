return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
		-- see below for full list of optional dependencies 👇
	},
	opts = {
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
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gd"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			["gr"] = {
				action = function()
					return "<cmd>ObsidianBacklinks<CR>"
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
			return suffix
		end,
	},
	config = function(_, opts)
		require("obsidian").setup(opts)
		vim.keymap.set("n", "<leader>sf", vim.cmd.ObsidianQuickSwitch)
		vim.keymap.set("n", "<leader>sw", vim.cmd.ObsidianWorkspace)
		vim.keymap.set("n", "<leader>sl", vim.cmd.ObsidianLinks)
		vim.keymap.set("n", "<leader>nt", vim.cmd.ObsidianNew)
		vim.keymap.set("n", "<leader>nd", vim.cmd.ObsidianToday)
		vim.keymap.set("n", "<leader>rn", vim.cmd.ObsidianRename)
		vim.keymap.set("n", "<leader>st", vim.cmd.ObsidianTags)
		vim.keymap.set("n", "<leader>st", vim.cmd.ObsidianTags)
		-- vim.keymap.set("v", "<leader>nt", function()
		-- 	vim.cmd("ObsidianExtractNote")
		-- end)
	end,
}
