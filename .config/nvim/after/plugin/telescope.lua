local telescope = require('telescope')
local actions = require "telescope.actions"

telescope.setup {
 defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
      },

      n = {
        ["<esc>"] = actions.close,

        ["<C-c>"] = actions.close,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
      },
    },
  },
}

local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

vim.keymap.set('n', '<leader>pf', function () return builtin.find_files(themes.get_dropdown{previewer = false, hidden = true}) end, {})
vim.keymap.set('n', '<C-p>', function () return builtin.git_files(themes.get_dropdown{previewer = false, hidden = true}) end, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string(themes.get_ivy({ search = vim.fn.input("Grep > ") }));
end)
vim.keymap.set('n', '<leader>pb', function () return builtin.buffers(themes.get_dropdown{previewer = false}) end, {})
vim.keymap.set('n', '<leader>pg', builtin.git_status, {})

