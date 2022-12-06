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
            bufnr = bufnr
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
    diagnostics.eslint_d.with({ diagnostics_format = '[eslint] #{m}\n(#{c})' }),
    code_actions.eslint_d,
    formatting.eslint_d
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

        -- TODO: support
        -- if client.supports_method("textDocument/hover") then
        -- end
    end
}
