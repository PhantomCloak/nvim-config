-- ===========================
-- Bottom bar
-- ===========================

lualineCfg = {
    options = {
        theme = 'codedark',
        globalstatus = true,
    },
    sections = {
        lualine_x = { '', '', '' },
    },
}

require("lualine").setup(lualineCfg)
