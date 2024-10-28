return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- adapters
    { "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
    "nvim-neotest/neotest-jest",
    "thenbe/neotest-playwright",
  },
  config = function()
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)

    -- local neotest = require("neotest")
    require("neotest").setup({
      -- your neotest config here
      adapters = {
        require("neotest-golang"),
        require("neotest-playwright").adapter({
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
          },
        }),
        -- Had to go to the code and remove hasJestDependency from line 124 in /Users/blagojpetrovoffice/.local/share/nvim/site/pack/packer/start/neotest-jest/init.lua
        -- It seems like hasJestDependency is executed after in my case. Updating to lazy.vim or bumping neovim version might help
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.ts",
          env = { NODE_ENV = "test" },
          cwd = function(_path)
            return vim.fn.getcwd()
          end,
        }),
      },
    })

    -- should use require, instead of the cached version with local
    vim.keymap.set("n", "<leader>pt", function()
      require("neotest").summary.toggle()
    end)
    vim.keymap.set("n", "<leader>tv", function()
      require("neotest").output_panel.open()
    end)
    -- -- at file
    vim.keymap.set("n", "<leader>tf", function()
      require("neotest").run.run(vim.fn.expand("%"))
    end)
    -- -- at cursor
    vim.keymap.set("n", "<leader>tr", function()
      require("neotest").run.run()
    end)
    --
    vim.keymap.set("n", "<leader>ts", function()
      require("neotest").run.stop()
    end)
    vim.keymap.set("n", "<leader>td", function()
      require("neotest").run.run({ strategy = "dap" })
    end)
  end
}
