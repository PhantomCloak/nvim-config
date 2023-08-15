-- ===========================
-- Syntax highligting for default & LSP tokens
-- ===========================

treeSitterCfg = {
    ensure_installed = { "c", "lua" },
    sync_install = false,
    auto_install = true,
    ignore_install = { "javascript" },
    textobjects = {
        move = {
            enable = false,
            set_jumps = true,
            goto_next_end = {
                ["]]"] = "@function.outer",
            },
            goto_previous_start = {
                ["[["] = "@function.outer",
            },
        },
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

local nvimtreesitter = require('nvim-treesitter.configs')
nvimtreesitter.setup(treeSitterCfg)
