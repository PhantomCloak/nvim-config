require 'plugins'
require 'configs'
require 'globals'
require 'keymaps'
require 'options'
require 'snippets'

require('impatient')

-- VIM CONFIGS

vim.opt.termguicolors = true -- 256 color support

nvimtreesitter.setup(treeSitterCfg)

bqf.setup()
qf.setup()
dressing.setup()

require('cmp').setup(cmpConfig)
lspconfig.omnisharp.setup(omnisharpLspCfg)
lspconfig.clangd.setup(clangdLspCfg)
lspfuzzy.setup(fzfLspFuzzyCfg)
neoterm.setup(neoTermCfg)

dapui.setup(dapUiCfg);

lspcolors.setup()
lspsignature.setup(lspSignatureCfg)
lspformat.setup()

navic.setup(navicCfg)

lualine.setup(lualineCfg)
trouble.setup(troubleCfg)
autopairs.setup()
mason.setup()

bufferline.setup(bufferLineCfg)

vim.api.nvim_set_hl(0, "TreesitterContext",{default = false, bg = "#363c4c"})
vim.cmd [[
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
]]

