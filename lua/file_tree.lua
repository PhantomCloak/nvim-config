-- ===========================
-- Filebrowser tree
-- ===========================

require"nvim-tree.view".View.winopts.cursorline = true

local tree_key_maps = {
    { key = "R", action = "none" },
    { key = "a", action = "create" },
    { key = "FF", action = "none" },
    { key = "ff", action = "none" },
    { key = {"<CR>"}, action = "edit" },
}

treeCfg = {
    open_on_tab = true,
    prefer_startup_root = true,
    view = {
        centralize_selection = true,
        side = "left",
        width = 35,
        preserve_window_proportions = true,
        hide_root_folder = true,
        signcolumn = "no",
        mappings = {
         custom_only = true,
          list = tree_key_maps,
        },
    },
    update_focused_file = {
        enable = true
    },
    renderer = {
        icons = {
            show = {
                folder_arrow = true,
                file = false,
                git = false
            },
            glyphs = {
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                },
           },
        },
    },
    filters = {
        dotfiles = true,
        custom = { "*.meta" },
    },
    git = {
        enable = false
    },
}

local nvimtree = require('nvim-tree')
nvimtree.setup(treeCfg)
