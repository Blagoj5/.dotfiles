local dap = require("dap")

-- local function debugJest(testName, filename)
-- 	print("starting " .. testName .. " in " .. filename)
-- 	dap.run({
-- 		type = "node2",
-- 		request = "launch",
-- 		cwd = vim.fn.getcwd(),
-- 		runtimeArgs = { "--inspect-brk", "/usr/local/bin/jest", "--no-coverage", "-t", testName, "--", filename },
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 		skipFiles = { "<node_internals>/**/*.js" },
-- 		console = "integratedTerminal",
-- 		port = 9229,
-- 	})
-- end

-- local function attach()
-- 	print("attaching")
-- 	dap.run({
-- 		type = "node2",
-- 		request = "attach",
-- 		cwd = vim.fn.getcwd(),
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 		skipFiles = { "<node_internals>/**/*.js" },
-- 	})
-- end
--
-- local function attachToRemote()
-- 	print("attaching")
-- 	dap.run({
-- 		type = "node2",
-- 		request = "attach",
-- 		address = "127.0.0.1",
-- 		port = 9229,
-- 		localRoot = vim.fn.getcwd(),
-- 		remoteRoot = "/home/vcap/app",
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 		skipFiles = { "<node_internals>/**/*.js" },
-- 	})
-- end
--
dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
}

local jester = require("jester")
jester.setup({
	cmd = "node_modules/.bin/jest --runInBand --testNamePattern '$result' --testPathPattern $file", -- run command
	identifiers = { "test", "it" }, -- used to identify tests
	prepend = { "describe" }, -- prepend describe blocks
	expressions = { "call_expression" }, -- tree-sitter object used to scan for tests/describe blocks
	path_to_jest_run = "node_modules/.bin/jest", -- used to run tests
	path_to_jest_debug = "./node_modules/.bin/jest", -- used for debugging
	terminal_cmd = ":split test | execute \"normal \\<C-W>J\" | terminal", -- used to spawn a terminal for running tests, for debugging refer to nvim-dap's config
	-- path_to_config = "jest.config.ts",
	dap = { -- debug adapter configuration
		type = "node2",
		request = "launch",
		cwd = vim.fn.getcwd(),
		runtimeArgs = { "--inspect-brk", "$path_to_jest", "--no-coverage", "-t", "$result", "--", "$file" },
		args = { "--no-cache" },
		sourceMaps = false,
		protocol = "inspector",
		skipFiles = { "<node_internals>/**/*.js" },
		console = "integratedTerminal",
		port = 9229,
		disableOptimisticBPs = true,
	},
})

vim.keymap.set("n", "<leader>ts", jester.run)
vim.keymap.set("n", "<leader>tf", jester.run_file)

vim.keymap.set("n", "<leader>ds", jester.debug)
vim.keymap.set("n", "<leader>dS", dap.terminate)
vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>si", dap.step_into)
vim.keymap.set("n", "<leader>sO", dap.step_out)
vim.keymap.set("n", "<leader>so", dap.step_over)
vim.keymap.set("n", "<leader>dj", dap.down)
vim.keymap.set("n", "<leader>dk", dap.up)
vim.keymap.set("n", "<leader>dk", dap.up)
vim.keymap.set("n", "<leader>dd", function()
	dap.disconnect()
	dap.stop()
	dap.run_last()
end)

local dap_widgets = require("dap.ui.widgets")
vim.keymap.set("n", "<leader>dK", dap_widgets.hover)

-- nnoremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
-- nnoremap <leader>di :lua require'dap.ui.variables'.hover()<CR>
-- vnoremap <leader>di :lua require'dap.ui.variables'.visual_hover()<CR>
-- nnoremap <leader>d? :lua require'dap.ui.variables'.scopes()<CR>
-- nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"})<CR>
-- nnoremap <leader>da :lua require'debugHelper'.attach()<CR>
-- nnoremap <leader>dA :lua require'debugHelper'.attachToRemote()<CR>
-- nnoremap <leader>di :lua require'dap.ui.widgets'.hover()<CR>
-- nnoremap <leader>d? :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>
