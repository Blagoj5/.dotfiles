-- Setting global options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.scrolloff = 8
vim.opt.termguicolors = true
-- vim.opt.guifont = "hack:12"
vim.g.mapleader = ' '

-- Remaps
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>c', '<cmd>bw<cr>')
vim.keymap.set('n', '<leader>C', '<cmd>e ~/.config/nvim/init.lua<cr>')

-- Auto commands
local augroup = vim.api.nvim_create_augroup('user_cmds', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'man' },
  group = augroup,
  desc = 'Use q to close the window',
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  desc = 'Highlight on yank',
  callback = function(event)
    vim.highlight.on_yank({ timeout = 200 })
  end
})

-- Plugins
require('baze.packer')
require('baze.themes.tokyonight')
require('baze.telescope')
require('baze.treesitter')
require('baze.gitsigns')
require('baze.nvimtree')
require('baze.lsp.lsp-config')
require('baze.lsp.null-ls')
-- TODO: configure the lua line
require('lualine').setup({
  theme = "tokyonight"
})
require("baze.comment")
require("baze.autopairs")
require("baze.surround")
require("baze.zen")
