" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'

"Plug 'neoclide/coc-pairs'
" My cool theme
Plug 'ayu-theme/ayu-vim' 
" Command palatte
Plug 'liuchengxu/vim-clap'
" basically find anything Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" for bracket helper
Plug 'nickspoons/vim-sharpenup'
" linter
Plug 'dense-analysis/ale'
" Find text
Plug 'jremmen/vim-ripgrep'

" file explorer
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
" sexy colors Plug 'itchyny/lightline.vim' Plug 'nvim-lua/plenary.nvim'

" git change visual
Plug 'airblade/vim-gitgutter'
Plug 'olimorris/onedarkpro.nvim'
Plug 'nvim-lua/plenary.nvim'
" search bar and other stuffs
Plug 'nvim-telescope/telescope.nvim'
" show telescope env vars
Plug 'LinArcX/telescope-env.nvim'
" cool tree like vs code
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 's1n7ax/nvim-terminal'
Plug 'puremourning/vimspector'

" idk but it makes vim better they say
Plug 'tpope/vim-sensible'
Plug 'itchyny/vim-gitbranch'

Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" LSP magic
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'ray-x/lsp_signature.nvim'

Plug 'MaskRay/ccls'
Plug 'antoinemadec/FixCursorHold.nvim'

Plug 'OmniSharp/omnisharp-vim'
Plug 'wellle/targets.vim'
" 
" pick project root
Plug 'airblade/vim-rooter'
Plug 'nvim-treesitter/nvim-treesitter'

if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction

  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'

  " To use Python remote plugin features in Vim, can be skipped
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'jiangmiao/auto-pairs'
endif

call plug#end()

set shiftwidth=4
" show command pop-up
call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_palette_theme({
      \ 'border': 'rounded',
      \ 'max_height': '75%',
      \ 'min_height': 0,
      \ 'prompt_position': 'top',
      \ 'reverse': 0,
      \ })))


let g:OmniSharp_selector_ui = 'telescope' 
let g:OmniSharp_selector_findusages = 'telescope'

" Key bindings can be changed, see below
call wilder#setup({'modes': [':', '/', '?']})
" Note that neovim does not support `popuphidden` or `popup` yet:
" https://github.com/neovim/neovim/issues/10996
if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  set completepopup=highlight:Pmenu,border:off
endif

set termguicolors     " enable true colors support
let ayucolor="light"  " for light version of theme
colorscheme desert

let g:ale_linters = { 'cs': ['OmniSharp'] }
let g:cursorhold_updatetime = 100

" make highlighting better for omnisharp
let g:OmniSharp_highlight_groups = {
\ 'ExcludedCode': 'NonText',
\ 'ClassName': 'Type',
\ 'EnumName': 'Type',
\ 'NamespaceName': 'Include',
\ 'RegexComment': 'Comment',
\ 'RegexCharacterClass': 'Character',
\ 'RegexAnchor': 'Type',
\ 'RegexQuantifier': 'Number',
\ 'RegexGrouping': 'Macro',
\ 'RegexAlternation': 'Identifier',
\ 'RegexText': 'String',
\ 'RegexSelfEscapedCharacter': 'Delimiter',
\ 'LocalName': 0,
\ 'PropertyName': 0,
\ 'ParameterName': 0,
\ 'FieldName': 0
\}

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

 lua << EOF

require('telescope').load_extension('env')

require'telescope'.setup({
    defaults = {
        file_ignore_patterns = { "^./.git/", "^node_modules/", "^vendor/", "%.meta",
	"%.asset","%.unity", "%.ttf", "%.png", "%.jpg", "%.prefab", "%.ogg",
	"%.anim", "%.fbx", "%.obj", "%.tga", "%.shader", "%.swcode", "%.mat",
	"%.vfx", "%.FBX", "%.asmdef", "%.controller", "%.dll", "%.TGA",
	"%.file"},
    }
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "rust" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },
  highlight = {
    enable = false,
    disable = {"csharp", "cs", "rust", "vim"},
    additional_vim_regex_highlighting = false,
  },
}


local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },
  sources = {
    { name = 'nvim_lsp' },
  }
}

require'lspconfig'.omnisharp.setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
  cmd = { "/Users/unalozyurt/Downloads/omnisharp-osx-x64-net6.0/OmniSharp", "--languageserver" , "--hostPID", tostring(pid) },
}


 cfg = {
  debug = false, -- set to true to enable debug logging
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  max_height = 12, -- max height of signature floating_window
  max_width = 80, -- max_width of signature floating_window
  wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
  
  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap

  floating_window_off_x = 1, -- adjust float windows x position.
  floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines

  close_timeout = 4000, -- close floating window after ms when laster parameter is entered
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  handler_opts = {
    border = "rounded"   -- double, rounded, single, shadow, none
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

  select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
  move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
}

-- recommended:
require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key



local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true } 

-- map('gr', ':Telescope lsp_references<CR>', {noremap = true, silent = false})
keymap("n", "gr", ":Telescope lsp_references<CR>", opts)
keymap("n", "gd", ":Telescope lsp_definitions<CR>", opts)

keymap("n", "rn", ":lua lua.vim.lsp.buf.rename()<CR>", opts)
keymap("n", "gr", ":Telescope lsp_references<CR>", opts)
keymap("n", "<leader>dD", ":Telescope lsp_document_diagnostics<CR>", opts)
keymap("n", "<leader>dW", ":Telescope lsp_workspace_diagnostics<CR>", opts)
keymap("n", "<leader>ca", ":%Telescope lsp_range_code_actions", opts)

vim.g["number"] = 1

EOF

hi Pmenu        ctermfg=black ctermbg=black gui=NONE guifg=#98fb98 guibg=#6d6d6d  

let g:last_char = 'd'
function s:test() abort
    let curChar = strcharpart(strpart(getline('.'), col('.') - 2), 0, 1)

    if(g:last_char == curChar)
	return
    endif

    let save_pos = getpos(".")
    if (curChar == '(')
	execute "normal \<Plug>(omnisharp_signature_help)"
    endif
    call setpos('.', save_pos)

    let g:last_char = curChar
endfunction


" Find files using Telescope command-line sugar.
nnoremap <F3> :Telescope find_files<cr>
nnoremap <F4> :Telescope live_grep<cr>

" Livegrep on current file only
nnoremap <leader>ff :lua require'telescope.builtin'.live_grep({grep_open_files=true})<cr>


" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree | wincmd p
"autocmd VimEnter * if &modifiable | NERDTreeFind | wincmd p | endif

set splitbelow
let g:SuperTabDefaultCompletionType = "<c-n>"

autocmd VimEnter * :10sp | term
au VimEnter * wincmd w

noremap tn  :tabedit<Space><CR>
nnoremap <leader>lg :lua require('telescope.builtin').live_grep()<CR>
"nnoremap <Leader>dd :call vimspector#Launch()<CR>
nmap <Leader>di <Plug>VimspectorBalloonEval
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <F5> :call vimspector#Continue()<CR>

nnoremap <F9> :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dt<Plug>VimspectorStop
nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
nmap <Leader> do <Plug>VimspectorStepOver

" Change these if you want
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

" I find the numbers disctracting
let g:signify_sign_show_count = 1
let g:signify_sign_show_text = 1


" Jump though hunks
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
nmap <leader>gJ 9999<leader>gJ
nmap <leader>gK 9999<leader>gk

nmap <Leader>gb : Git blame<CR>
"nmap <Leader>gd : GBrowse<CR>
"nmap <Leader>gr : GV?<CR>
