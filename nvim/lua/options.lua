-- NAVIC OPS

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

vim.api.nvim_set_hl(0, "NavicText",{default = false, bg = "#1f2430", fg = "#73d0ff"})
vim.api.nvim_set_hl(0, "NavicIconsMethod",{default = false, bg = "#1f2430", fg = "#c078b8"})
vim.api.nvim_set_hl(0, "NavicIconsClass",{default = false, bg = "#1f2430", fg = "#c078b8"})
vim.api.nvim_set_hl(0, "NavicIconsNamespace",{default = false, bg = "#1f2430", fg = "#c078b8"})

-- EDITOR OPTIONS

vim.o.signcolumn = 'yes:2'
vim.wo.number = true
vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- DIAGNOSTICS

vim.diagnostic.config({virtual_text = {prefix = '🦀'}}) 

-- VIM FUNCS
--vim.opt.titlestring = 🦊\ %(%{expand(\"%:~:.:h\")}%)/%t\ -\ NVim\ 🦊