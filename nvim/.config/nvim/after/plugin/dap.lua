local dap = require("dap")
local dapui = require("dapui")

require("dapui").setup()
require("dap-go").setup()
require("nvim-dap-virtual-text").setup()

-- vim.api.nvim_exec(
-- 	[[
-- 		function! JestStrategy(cmd)
-- 			let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
-- 			let fileName = matchlist(a:cmd, '\v'' -- (.*)$')[1]
-- 			call luaeval("require('baze/debugHelpers').debugJest(\[\[" . testName . "\]\], \[\[" . fileName . "\]\])")
-- 		endfunction
--
-- 		let g:test#custom_strategies = {'jest-custom': function('JestStrategy')}
-- 		" let g:test#strategy = 'jest'
-- 	]],
-- 	false
-- )

-- dap.adapters.node2 = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = { os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
-- }

-- dap.configurations.javascript = {
-- 	{
-- 		name = "Launch",
-- 		type = "node2",
-- 		request = "launch",
-- 		program = "${file}",
-- 		cwd = vim.fn.getcwd(),
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 		console = "integratedTerminal",
-- 	},
-- }

-- require("dap.ext.vscode").load_launchjs()
-- Define a function to start the debugging session using a configuration name

-- dap.configurations.typescriptreact = {
-- 	{
-- 		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
-- 		name = "Attach to process",
-- 		processId = require("dap.utils").pick_process,
-- 		type = "node2",
-- 		request = "attach",
-- 		cwd = vim.fn.getcwd(),
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 		skipFiles = { "<node_internals>/**/*.js" },
-- 	},
-- }

-- Handled by nvim-dap-go
dap.adapters.go = {
	type = "server",
	port = "${port}",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

-- js/ts dap setup
require("dap-vscode-js").setup({
	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
	-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	-- adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
	adapters = { "pwa-node" }, -- which adapters to register in nvim-dap
	-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
	-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
	-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({ "typescript", "javascript" }) do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			name = "Debug Jest Tests",
			type = "pwa-node",
			request = "launch",
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			-- request = "launch",
			-- runtimeExecutable = "node",
			-- runtimeArgs = {
			-- 	"./node_modules/jest/bin/jest.js",
			-- 	"--runInBand",
			-- },
			-- console = "integratedTerminal",
			-- internalConsoleOptions = "neverOpen",
		},
	}
end

-- vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest -strategy=neovim<CR>")
-- vim.keymap.set("n", "<leader>tf", "<cmd>TestFile -strategy=neovim<CR>")
-- vim.keymap.set("n", "<leader>tS", "<cmd>TestSuite -strategy=neovim<CR>")
-- vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit -strategy=neovim<CR>")
-- vim.keymap.set("n", "<leader>tl", "<cmd>TestLast -strategy=neovim<CR>")
-- vim.keymap.set("n", "<leader>ts", "<cmd>TestNearest -strategy=jest-custom<CR>")

-- DAP keybinds
-- vim.keymap.set("n", "<leader>deb", dap.set_exception_breakpoints)
vim.keymap.set("n", "<leader>cb", dap.clear_breakpoints)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
vim.keymap.set("n", "<leader>B", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
-- Eval var under cursor, it might conflict with my stuff
-- vim.keymap.set("n", "<space>?", function()
vim.keymap.set("n", "<space>dK", function()
	require("dapui").eval(nil, { enter = true })
end)
vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F6>", function()
	dap.terminate()
	dapui.close()
end)

vim.keymap.set("n", "<F12>", dap.restart)

-- local function log_message(message)
-- 	local file = io.open("/Users/blagojpetrovoffice/my_nvim.log", "a") -- Open in append mode
-- 	io.output(file)
--   io.write(message)
--   io.close(file)
-- end

-- automatically open dapui on attach
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function(session, body)
	-- work project causes issue with this
	if not session.filetype == "typescript" and not session.filetype == "javascript" then
		dapui.close()
	end
end
dap.listeners.before.event_exited.dapui_config = function(session, body)
	-- log_message('Session exited' .. vim.inspect(session) .. vim.inspect(body))
	dapui.close()
end
