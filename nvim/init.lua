require 'plugins'
require 'configs'
require 'globals'
require 'keymaps'
require 'options'

require('impatient')

-- VIM CONFIGS

vim.opt.termguicolors = true -- 256 color support

nvimtreesitter.setup(treeSitterCfg)

bqf.setup()
qf.setup()
dressing.setup()

require('cmp').setup(cmpConfig)
require('nvim-tree').setup(treeCfg)

lspconfig.omnisharp.setup(omnisharpLspCfg)
lspconfig.clangd.setup(clangdLspCfg)

lspfuzzy.setup(fzfLspFuzzyCfg)
dapui.setup(dapUiCfg);

lspsignature.setup(lspSignatureCfg)
lspformat.setup()

lualine.setup(lualineCfg)
trouble.setup(troubleCfg)
autopairs.setup()


bufferline.setup(bufferLineCfg)
vim.api.nvim_set_hl(0, "TreesitterContext",{default = false, bg = "#363c4c"})

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


  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = false,
    }
  )

require('gitsigns').setup()


