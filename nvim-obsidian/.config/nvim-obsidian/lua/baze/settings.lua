local global = vim.g
local o = vim.opt

-- Editor options
o.autoindent = true -- Copy indent from current line when starting a new line.
o.clipboard = "unnamedplus" -- uses the clipboard register for all operations except yank.
o.conceallevel = 2
o.cursorline = true -- Highlight the screen line of the cursor with CursorLine.
o.encoding = "UTF-8" -- Sets the character encoding used inside Vim.
o.expandtab = true -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
o.hidden = true -- When on a buffer becomes hidden when it is |abandon|ed
o.inccommand = "split" -- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.
o.mouse = "a" -- Enable the use of the mouse. "a" you can use on all modes
o.number = true -- Print the line number in front of each line
o.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line.
o.ruler = true -- Show the line and column number of the cursor position, separated by a comma.
o.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent.
o.showcmd = true -- Show (partial) command in the last line of the screen. Set this option off if your terminal is slow.
o.showmatch = true -- When a bracket is inserted, briefly jump to the matching one.
o.softtabstop = 2
o.splitbelow = true -- When on, splitting a window will put the new window below the current one
o.splitright = true
o.syntax = "on" -- When this option is set, the syntax with this name is loaded.
o.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for.
o.termguicolors = true
o.title = true -- When on, the title of the window will be set to the value of 'titlestring'
o.ttimeoutlen = 0 -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
o.wildmenu = true -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
vim.g.mapleader = " "
vim.opt.backup = false
vim.opt.clipboard:append("unnamedplus")
vim.opt.colorcolumn = "80"
vim.opt.expandtab = true
vim.opt.guicursor = ""
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.isfname:append("@-@")
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.wrapscan = false
-- vim.opt.textwidth = 80
