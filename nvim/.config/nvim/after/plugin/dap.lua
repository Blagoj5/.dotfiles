local dap = require("dap")
local dapui = require("dapui")

require("dapui").setup()
require("dap-go").setup()
require("nvim-dap-virtual-text").setup()

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
	adapters = { "pwa-node" }, -- which adapters to register in nvim-dap
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
