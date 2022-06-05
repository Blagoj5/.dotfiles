-- vim.g.tokyonight_transparent = true;
vim.g.gruvbox_contrast_dark = 'hard';
vim.cmd [[
try
  set background=dark
  colorscheme gruvbox
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
