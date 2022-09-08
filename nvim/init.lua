require 'plugins'
require 'globals'
require 'configs'
require 'options'
require 'keymaps'

-- VIM CONFIGS

vim.opt.termguicolors = true -- 256 color support

-- PLUG INIT

ayu.setup({mirage = true})
ayu.colorscheme()

nvimtree.setup(treeCfg)
nvimtreesitter.setup(treeSitterCfg)
bufferline.setup()

bqf.setup()
qf.setup()
dressing.setup()

lspconfig.omnisharp.setup(omnisharpLspCfg)
lspconfig.clangd.setup(clangdLspCfg)
cmp.setup(cmpConfig)

dap.adapters.codelldb = dapCodeLLDBCfg
dap.configurations.c = dapCCfg
dap.repl.commands = vim.tbl_extend('force', dap.repl.commands, dapReplCfg)

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.cpp

dapui.setup(dapUiCfg);

lspcolors.setup()
lspsignature.setup(lspSignatureCfg)
lspformat.setup()

navic.setup(navicCfg)

telescope.setup(telescopeCfg)
telescope.load_extension('command_palette')
telescope.load_extension('lsp_handlers')

lualine.setup(lualineCfg)
trouble.setup(troubleCfg)
autopairs.setup()

mason.setup()
require"nvim-tree.view".View.winopts.cursorline = true