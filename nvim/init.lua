require 'plugins'
require 'configs'
require 'globals'
require 'keymaps'
require 'options'
require 'snippets'

require('impatient')

-- VIM CONFIGS

--vim.opt.termguicolors = true -- 256 color support

-- PLUG INIT

--ayu.setup({mirage = true})
--ayu.colorscheme()

nvimtree.setup(treeCfg)
nvimtreesitter.setup(treeSitterCfg)

bqf.setup()
qf.setup()
dressing.setup()

lspconfig.omnisharp.setup(omnisharpLspCfg)
lspconfig.clangd.setup(clangdLspCfg)
require('cmp').setup(cmpConfig)
require('lspfuzzy').setup(fzfLspFuzzyCfg)

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

lualine.setup(lualineCfg)
trouble.setup(troubleCfg)
autopairs.setup()
require'hop'.setup()
mason.setup()

require"nvim-tree.view".View.winopts.cursorline = true

vim.api.nvim_set_hl(0, "TreesitterContext",{default = false, bg = "#363c4c"})

vim.cmd [[
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
]]


bufferline.setup(bufferLineCfg)
vim.cmd [[
colorscheme vscode

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_preview_window = ['right:50%:noborder']
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline --height 40% --preview-window noborder'

let $FZF_DEFAULT_COMMAND="rg --files --hidden"
let $FZF_DEFAULT_COMMAND = 'rg -g "*.cs" -g "*.cpp" -g "*.h" --files --hidden'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=never --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

  function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg -g "*.cs" -g "*.cpp" -g "*.h" --column --line-number --no-heading --color=always --smart-case %s | sed "s/ \{1,\}/ /g" || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command, '--with-nth=..4']}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

hi BufferLineBackground guifg=#9c9c9c guibg=#646464 
hi BufferLineSeparator guifg=#252526 guibg=#646464 
hi BufferLineCloseButton guifg=#9c9c9c guibg=#646464 
hi BufferLineDevIconLua guibg=#646464
hi BufferLineDevIconCs guibg=#646464
hi BufferLineDevIconCpp guibg=#646464
hi BufferLineDevIconH guibg=#646464
hi BufferLineDevIconDockerfile guibg=#646464
hi BufferLineDevIconHeader guibg=#646464
hi BufferLineDevIconJson guibg=#646464
hi Directory guibg=#252526
let $FZF_DEFAULT_OPTS = '--bind tab:down,shift-tab:up'
enew
]]

require('sterm').setup({
	split_direction = "down" -- right, left, up or down
})


vim.keymap.set("n", "tt", ":NeotermToggle<CR>", { silent=true })
require('neoterm').setup({
	clear_on_run = true, -- run clear command before user specified commands
	mode = 'horizontal',   -- vertical/horizontal/fullscreen
	noinsert = false     -- disable entering insert mode when opening the neoterm window
})
