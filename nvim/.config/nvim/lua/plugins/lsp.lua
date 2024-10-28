return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require('mason-lspconfig').setup()


      require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          local attach = function(_client, bufnr)
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

            -- Many LSP don't support this, so it won't work
            vim.api.nvim_buf_create_user_command(bufnr, "RenameFile", function()
              local bufName = (vim.api.nvim_buf_get_name(bufnr))
              local newBufName = vim.fn.input("Rename to: ", bufName)
              vim.lsp.util.rename(bufName, newBufName)
            end, {})
          end

          if server_name == "lua_ls" then
            require("lspconfig")[server_name].setup {
              on_attach = attach,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' },
                  },
                },
              },
            }
          else
            require("lspconfig")[server_name].setup {
              on_attach = attach
            }
          end
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function ()
        --   require("rust-tools").setup {}
        -- end
      }
    end,

    vim.diagnostic.config({
      virtual_text = true,
    })
  },
  "neovim/nvim-lspconfig",
  "mfussenegger/nvim-lint",
  {
    "mhartington/formatter.nvim",
    config = function()
      -- Utilities for creating configurations
      -- local util = require "formatter.util"

      -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
      require("formatter").setup {
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
      }
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

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
    end
  },

  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
  },
}
