local dap = require("dap")

vim.api.nvim_exec(
	[[
		function! JestStrategy(cmd)
			let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
			let fileName = matchlist(a:cmd, '\v'' -- (.*)$')[1]
			call luaeval("require('baze/debugHelpers').debugJest(\[\[" . testName . "\]\], \[\[" . fileName . "\]\])")
		endfunction

		let g:test#custom_strategies = {'jest-custom': function('JestStrategy')}
		" let g:test#strategy = 'jest'
	]],
	false
)

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
}

-- UI FOR DAP
local dapui = require("dapui")
dapui.setup({
	icons = { expanded = "", collapsed = "", current_frame = "" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	-- Use this to override mappings for specific elements
	element_mappings = {
		-- Example:
		-- stacks = {
		--   open = "<CR>",
		--   expand = "o",
		-- }
	},
	expand_lines = true,
	-- Layouts define sections of the screen to place windows.
	-- The position can be "left", "right", "top" or "bottom".
	-- The size specifies the height/width depending on position. It can be an Int
	-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
	-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
	-- Elements are the elements shown in the layout (in order).
	-- Layouts are opened in order so that earlier layouts take priority in window sizing.
	layouts = {
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.25 },
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40, -- 40 columns
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 0.25, -- 25% of total lines
			position = "bottom",
		},
	},
	controls = {
		-- Requires Neovim nightly (or 0.8 when released)
		enabled = true,
		-- Display controls in this element
		element = "repl",
		icons = {
			pause = "",
			play = "",
			step_into = "",
			step_over = "",
			step_out = "",
			step_back = "",
			run_last = "",
			terminate = "",
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>", "<Ctrl-c>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
		max_value_lines = 100, -- Can be integer or nil.
	},
})

-- automatically open dapui on attach
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

require("nvim-dap-virtual-text").setup()

vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest -strategy=neovim<CR>")
vim.keymap.set("n", "<leader>tf", "<cmd>TestFile -strategy=neovim<CR>")
vim.keymap.set("n", "<leader>tS", "<cmd>TestSuite -strategy=neovim<CR>")
vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit -strategy=neovim<CR>")
vim.keymap.set("n", "<leader>tl", "<cmd>TestLast -strategy=neovim<CR>")
vim.keymap.set("n", "<leader>ts", "<cmd>TestNearest -strategy=jest-custom<CR>")

vim.keymap.set("n", "<leader>cb", dap.clear_breakpoints)
vim.keymap.set("n", "<leader>tb", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>tB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>deb", dap.set_exception_breakpoints)
vim.keymap.set("n", "<leader>dso", dap.step_over)
vim.keymap.set("n", "<leader>dsi", dap.step_into)
vim.keymap.set("n", "<leader>dsO", dap.step_out)
vim.keymap.set("n", "<leader>dq", dap.repl.open)
vim.keymap.set("n", "<leader>dQ", dap.terminate)
vim.keymap.set("n", "<leader>duo", dapui.toggle)
vim.keymap.set("n", "<leader>dK", dapui.eval)
