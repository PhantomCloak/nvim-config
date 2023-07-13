-- NAVIC OPS

--vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

vim.opt.termguicolors = true -- 256 color support

vim.api.nvim_set_hl(0, "NavicText",{default = true, bg = "#1f2430", fg = "#73d0ff"})
vim.api.nvim_set_hl(0, "NavicIconsMethod",{default = true, bg = "#1f2430", fg = "#c078b8"})
vim.api.nvim_set_hl(0, "NavicIconsClass",{default = true, bg = "#1f2430", fg = "#c078b8"})
vim.api.nvim_set_hl(0, "NavicIconsNamespace",{default = true, bg = "#1f2430", fg = "#c078b8"}) 

-- EDITOR OPTIONS

vim.o.signcolumn = 'yes:1'
vim.wo.number = true
vim.o.cmdheight = 0
vim.o.pumheight = 15
vim.o.cinkeys = '0{,0},0),0#,!^F,o,O,e.'
vim.opt.termguicolors = true
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1


-- FORMATTING OPTIONS

vim.o.expandtab = true
vim.o.smartindent = true

vim.opt.lazyredraw = true

vim.o.backspace = 'indent,eol,start'

-- Search options
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wrapscan = true

-- Enable undo features, even after closing vim
vim.o.undofile = true
vim.o.undodir = os.getenv('HOME') .. '/.cache/nvim'
vim.o.undolevels = 10000

-- Move swapfiles and backupfiles to ~/.cache
vim.o.directory = os.getenv('HOME') .. '/.cache/nvim'
vim.o.backup = true
vim.o.backupdir = os.getenv('HOME') .. '/.cache/nvim'

-- Line options
vim.o.scrolloff = 12

-- DIAGNOSTICS

vim.diagnostic.config({virtual_text = {prefix = '🦀'}}) 

-- TREESITTER CONTEXt

vim.api.nvim_set_hl(0, "TreesitterContext",{default = false, bg = "#363c4c"})


-- VIM FUNCS
--vim.opt.titlestring = 🦊\ %(%{expand(\"%:~:.:h\")}%)/%t\ -\ NVim\ 🦊
