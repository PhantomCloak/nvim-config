bufferLineCfg = {
    options = {
        separator_style = "slant",
        close_icon = '',
        show_tab_indicators = false,
        enforce_regular_tabs = true,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                highlight = "Directory",
                padding = 1
            }
        },
    },
    highlights = {
        separator_selected = {
            fg = "#252526",
            bg = "#1e1e1e"
        },
    },
}

require("bufferline").setup(bufferLineCfg)