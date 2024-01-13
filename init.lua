-- OPTIONS
vim.opt.termguicolors = true

vim.api.nvim_set_hl(0, "NavicText",{default = true, bg = "#1f2430", fg = "#73d0ff"})
vim.api.nvim_set_hl(0, "NavicIconsMethod",{default = true, bg = "#1f2430", fg = "#c078b8"})
vim.api.nvim_set_hl(0, "NavicIconsClass",{default = true, bg = "#1f2430", fg = "#c078b8"})
vim.api.nvim_set_hl(0, "NavicIconsNamespace",{default = true, bg = "#1f2430", fg = "#c078b8"}) 

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

-- SEARCH OPTIONS
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

-- TREESITTER CONTEXt

vim.api.nvim_set_hl(0, "TreesitterContext",{default = false, bg = "#363c4c"})

-- Setup Plugins & Keymaps & Vim Options
require 'plugins'
require 'keymaps'

-- Setup UI
require 'tabs'
require 'status_bar'
require 'file_tree'


-- Setup LSP
require 'lsp'
require 'syntax_highlighter'
require 'debugger'
require 'diagnostics'

-- Setup Tools
require 'prompt'
require 'git'

-- VISUAL
bqf = require("bqf")
qf = require("qf")
dressing = require("dressing")
lspfuzzy = require('lspfuzzy')

require 'hex'.setup()
bqf.setup()
qf.setup()
dressing.setup()



-- Auto indention with insert mode
vim.cmd [[
hi Type guifg=#1e76ed
function! IndentWithI()
    if len(getline('.')) == 0
        return "\"_cc"
    else
        return "i"
    endif
endfunction
nnoremap <expr> i IndentWithI()
]]

-- Set something?
vim.api.nvim_set_hl(0, "TreesitterContext",{default = false, bg = "#363c4c"})


-- Disable virtual texts that came from LSP
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
   vim.lsp.diagnostic.on_publish_diagnostics,
   {
     --virtual_text = false,
   })


   
vim.cmd([[
hi BufferLineBackground guifg=#9c9c9c guibg=#646464 
hi BufferLineSeparator guifg=#252526 guibg=#646464 
hi BufferLineCloseButton guifg=#9c9c9c guibg=#646464 
hi BufferLineDevIconLua guibg=#646464
hi BufferLineDevIconCs guibg=#646464
hi BufferLineDevIconCpp guibg=#646464
hi BufferLineDevIconDefault guibg=#646464
hi BufferLineDevIconJson guibg=#646464
hi BufferLineDevIconH guibg=#646464
hi BufferLineDevIconDockerfile guibg=#646464
hi BufferLineDevIconHeader guibg=#646464
hi BufferLineDevIconJson guibg=#646464
hi BufferLineFill guibg=#252526
hi debugPC guibg=#424218
set signcolumn=number
]])
