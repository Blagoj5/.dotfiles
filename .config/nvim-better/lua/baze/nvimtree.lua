vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local nvim_tree = require('nvim-tree')

local nvim_tree_config = require("nvim-tree.config")
local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {"startify", "dashboard", "alpha"},
    open_on_tab = false,
    hijack_cursor = false,
    -- What is this for?
    hijack_directories = {
        enable = true,
        auto_open = true
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = ""
        }
    },
    system_open = {
        cmd = nil,
        args = {}
    },
    filters = {
        dotfiles = false,
        custom = {}
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500
    },
    view = {
        width = 30,
        hide_root_folder = false,
        side = "left",
        mappings = {
            custom_only = false,
            list = {{
                key = {"l", "<CR>", "o"},
                cb = tree_cb "edit"
            }, {
                key = "h",
                cb = tree_cb "close_node"
            }, {
                key = "v",
                cb = tree_cb "vsplit"
            }, {
                key = {"<CR>", "o", "<2-LeftMouse>"},
                action = "edit"
            }, {
                key = "<C-e>",
                action = "edit_in_place"
            }, {
                key = "O",
                action = "edit_no_picker"
            }, {
                key = {"<C-]>", "<2-RightMouse>"},
                action = "cd"
            }, {
                key = "<C-v>",
                action = "vsplit"
            }, {
                key = "<C-x>",
                action = "split"
            }, {
                key = "<C-t>",
                action = "tabnew"
            }, {
                key = "<",
                action = "prev_sibling"
            }, {
                key = ">",
                action = "next_sibling"
            }, {
                key = "P",
                action = "parent_node"
            }, {
                key = "<BS>",
                action = "close_node"
            }, {
                key = "<Tab>",
                action = "preview"
            }, {
                key = "K",
                action = "first_sibling"
            }, {
                key = "J",
                action = "last_sibling"
            }, {
                key = "I",
                action = "toggle_git_ignored"
            }, {
                key = "H",
                action = "toggle_dotfiles"
            }, {
                key = "U",
                action = "toggle_custom"
            }, {
                key = "R",
                action = "refresh"
            }, {
                key = "a",
                action = "create"
            }, {
                key = "d",
                action = "remove"
            }, {
                key = "D",
                action = "trash"
            }, {
                key = "r",
                action = "rename"
            }, {
                key = "<C-r>",
                action = "full_rename"
            }, {
                key = "x",
                action = "cut"
            }, {
                key = "yy",
                action = "copy"
            }, {
                key = "p",
                action = "paste"
            }, {
                key = "yn",
                action = "copy_name"
            }, {
                key = "yp",
                action = "copy_path"
            }, {
                key = "gy",
                action = "copy_absolute_path"
            }, {
                key = "[e",
                action = "prev_diag_item"
            }, {
                key = "[c",
                action = "prev_git_item"
            }, {
                key = "]e",
                action = "next_diag_item"
            }, {
                key = "]c",
                action = "next_git_item"
            }, {
                key = "-",
                action = "dir_up"
            }, {
                key = "s",
                action = "system_open"
            }, {
                key = "f",
                action = "live_filter"
            }, {
                key = "F",
                action = "clear_live_filter"
            }, {
                key = "q",
                action = "close"
            }, {
                key = "W",
                action = "collapse_all"
            }, {
                key = "E",
                action = "expand_all"
            }, {
                key = "S",
                action = "search_node"
            }, {
                key = ".",
                action = "run_file_command"
            }, {
                key = "<C-k>",
                action = "toggle_file_info"
            }, {
                key = "g?",
                action = "toggle_help"
            }, {
                key = "m",
                action = "toggle_mark"
            }, {
                key = "bmv",
                action = "bulk_move"
            }}
        },
        number = false,
        relativenumber = false
    },
    trash = {
        cmd = "trash",
        require_confirm = true
    },
    actions = {
        open_file = {
            quit_on_open = true,
            resize_window = true,
            window_picker = {
                enable = false
            }
        },
        change_dir = {
            enable = false,
            global = false,
            restrict_above_cwd = true
        }
    },
    update_cwd = false,
    update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {}
    },
    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true
            },
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = ""
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌"
                }
            }
        },
        special_files = {"Cargo.toml", "Makefile", "README.md", "readme.md"}
    }
}

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', {})
