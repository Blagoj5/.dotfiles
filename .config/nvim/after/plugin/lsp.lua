local lsp = require("lsp-zero")
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end
require("luasnip/loaders/from_vscode").lazy_load()

require("neodev").setup({})

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"html",
	"cssls",
	"tailwindcss",
	"sumneko_lua",
	"emmet_ls",
	"sqls",
})

lsp.configure("sqls", {
	settings = {
		sqls = {
			connections = {
				{
					driver = "mysql",
					dataSourceName = "root:admin@tcp(127.0.0.1:3306)/cfdb_79fee615_c1fb_11eb_9414_0ad79635d98a",
				},
				-- {
				-- 	driver = "postgresql",
				-- 	dataSourceName = "host=127.0.0.1 port=15432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable",
				-- },
			},
		},
	},
})

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-Space>"] = cmp.mapping.complete(),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expandable() then
			luasnip.expand()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		elseif check_backspace() then
			fallback()
		else
			fallback()
		end
	end, {
		"i",
		"s",
	}),
	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, {
		"i",
		"s",
	}),
})

-- disable completion with tab
-- this helps with copilot setup
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

vim.diagnostic.config({
	virtual_text = true,
})

vim.keymap.set("n", "<space>lq", vim.diagnostic.setloclist, { noremap = true, silent = true })

lsp.on_attach(function(_client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	-- if client.name == "eslint" then
	--   vim.cmd [[ LspStop eslint ]]
	--   return
	-- end

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>ld", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "<leader>ca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "gr", function()
		require('telescope.builtin').lsp_references()
	end, opts)
  -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	vim.keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end)

lsp.setup()

local ts_on_attach = function(client, bufnr)
	vim.keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
	vim.keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports
	vim.keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables
end

-- configure typescript server with plugin
require("typescript").setup({
	server = {
		on_attach = ts_on_attach,
	},
})

local null_ls = require("null-ls")

local lsp_code_action = function()
	vim.lsp.buf.code_action()
end

local lsp_formatting = function(bufnr)
	return function()
		vim.lsp.buf.format({
			filter = function(client)
				return client.name == "null-ls"
			end,
			bufnr = bufnr,
			timeout_ms = 30000,
		})
	end
end

local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting
-- local hover = null_ls.builtins.hover
local sources = {
	-- diagnostics.cspell,
	-- code_actions.cspell,
	code_actions.eslint_d,
	formatting.eslint_d,
	formatting.prettier, -- js/ts formatter
	formatting.stylua, -- lua formatter
	diagnostics.eslint_d.with({ -- js/ts linter
		-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
		condition = function(utils)
			return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc") -- change file extension if you use something else
		end,
	}),
}

null_ls.setup({
	sources = sources,
	on_attach = function(client, bufnr)
		local bufopts = {
			noremap = true,
			silent = true,
			buffer = bufnr,
		}
		if client.supports_method("textDocument/formatting") then
			vim.keymap.set("n", "<space>f", lsp_formatting(bufnr), bufopts)
		end

		if client.supports_method("textDocument/codeAction") then
			vim.keymap.set("n", "<space>la", lsp_code_action, bufopts)
		end
	end,
})

local mason_null_ls = require("mason-null-ls")

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})
