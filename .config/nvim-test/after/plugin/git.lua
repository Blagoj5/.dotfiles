vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
vim.keymap.set("n", "<leader>gd", "<cmd>:Gvdiffsplit!<cr>");
vim.keymap.set("n", "<leader>gl", "<cmd>:G blame<cr>");

local Baze_Fugitive = vim.api.nvim_create_augroup("Baze_Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
  group = Baze_Fugitive,
  pattern = "*",
  callback = function()
    if vim.bo.ft ~= "fugitive" then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "<leader>p", function()
      vim.cmd [[ Git push ]]
    end, opts)

    -- rebase always
    vim.keymap.set("n", "<leader>P", function()
      vim.cmd [[ Git pull --rebase ]]
    end, opts)

    -- NOTE: It allows me to easily set the branch i am pushing and any tracking
    -- needed if i did not set the branch up correctly
    vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
  end,
})

require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Navigation
    vim.keymap.set('n', '<leader>gj', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    vim.keymap.set('n', '<leader>gk', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    vim.keymap.set({'n', 'v'}, '<leader>gr', ':Gitsigns reset_hunk<CR>')
    vim.keymap.set('n', '<leader>gR', gs.reset_buffer)
    -- vim.keymap.set('n', '<leader>hp', gs.preview_hunk)
    -- vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame)
    -- vim.keymap.set('n', '<leader>hd', gs.diffthis)
    -- vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end)
    -- vim.keymap.set('n', '<leader>td', gs.toggle_deleted)
  end
}
