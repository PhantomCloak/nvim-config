-- Setup Plugins & Keymaps & Vim Options
require 'plugins'
require 'keymaps'
require 'options'

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

bqf = require("bqf")
qf = require("qf")
dressing = require("dressing")
lspfuzzy = require('lspfuzzy')

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
     virtual_text = false,
   })
