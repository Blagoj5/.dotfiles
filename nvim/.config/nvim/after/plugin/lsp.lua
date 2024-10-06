local lsp = require("lsp-zero")
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end
-- require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/.config/nvim/snippets"})
require("luasnip.loaders.from_snipmate").load()

-- Define a snippet that expands a dot into a `console.log` statement
-- local dot_snippet = luasnip.parser.parse_snippet({
-- trig = ".",  -- Trigger word
-- trig = "test",  -- Trigger word
-- name = "dot_snippet",
-- dscr = "Console.log for word before dot",
-- wordTrig = true, -- This is used to capture the word before the dot
-- fn = function(args)
-- local log_statement = ls.parser.parse_snippet("console.log(${1});")
-- local word = args[1].txt -- Get the text before the dot
--
-- log_statement:add_dynamic(ls.dynamicNode(1, function(_, _)
--   return {word}
-- end))
--
-- return log_statement
-- :send,
-- })

-- good snippets https://github.com/honza/vim-snippets
-- require("luasnip/loaders/from_vscode").lazy_load({ paths = {} })
-- luasnip.snippets = {
--   all = {},
--   typescript = { dot_snippet },
--   -- Add more snippet tables for other file types if needed
-- }

require("neodev").setup({})

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		{ name = "buffer" },
	}),
	mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		["<CR>"] = cmp.mapping.confirm({ select = false }),

		-- Scroll up and down in the completion documentation
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),

		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-Space>"] = cmp.mapping.complete(),

		-- disable completion with tab
		-- this helps with copilot setup
		["<Tab>"] = nil,
		["<S-Tab>"] = nil,
	}),
})

lsp.set_sign_icons({
	error = "E",
	warn = "W",
	hint = "H",
	info = "I",
})

vim.diagnostic.config({
	virtual_text = true,
})

vim.keymap.set("n", "<space>lq", vim.diagnostic.setloclist, { noremap = true, silent = true })

lsp.on_attach(function(_client, bufnr)
	local opts = { buffer = bufnr, remap = false }
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
		require("telescope.builtin").lsp_references()
	end, opts)
	-- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	vim.keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end)

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
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting
-- local hover = null_ls.builtins.hover
local sources = {
	formatting.stylua, -- lua formatter
	formatting.yamlfmt, -- lua formatter
	-- formatting.prettierd, -- it's coming from main mason
	-- formatting.eslint, -- eslint_d  as formatter
	-- code_actions.eslint,
	-- diagnostics.eslint, -- js/ts linter
	formatting.eslint_d, -- eslint_d  as formatter
	code_actions.eslint_d,
	diagnostics.eslint_d.with({ -- js/ts linter
		-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
		condition = function(utils)
			return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc") or utils.root_has_file("eslint.config.mjs") -- change file extension if you use something else
		end,
	}),
}

require("mason").setup()
require("mason-null-ls").setup({
	ensure_installed = {
		"prettierd", -- ts/js formatter
		"stylua", -- lua formatter
		-- "eslint_d", -- ts/js linter
		"eslint", -- ts/js linter
	},
	automatic_setup = true,
})
null_ls.setup({
	sources = sources,
})
require("mason-lspconfig").setup({
	ensure_installed = {
		-- "prettier", -- ts/js formatter
		-- "stylua", -- lua formatter
		-- "eslint_d", -- ts/js linter
	},
	automatic_setup = true,
	handlers = {
		lsp.default_setup,
	},
})
