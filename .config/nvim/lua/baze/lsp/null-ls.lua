-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
  return
end

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
    -- formatting.prettier, -- js/ts formatter
    formatting.stylua, -- lua formatter
    diagnostics.eslint_d.with({ -- js/ts linter
      -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc") -- change file extension if you use something else
      end,
    }),
}

null_ls.setup {
    sources = sources,
    on_attach = function(client, bufnr)
        local bufopts = {
            noremap = true,
            silent = true,
            buffer = bufnr
        }
        if client.supports_method("textDocument/formatting") then
            vim.keymap.set('n', '<space>lf', lsp_formatting(bufnr), bufopts)
        end

        if client.supports_method("textDocument/codeAction") then
            vim.keymap.set('n', '<space>la', lsp_code_action, bufopts)
        end
    end
}
