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

Plug 'ervandew/supertab'
" idk but it makes vim better they say
Plug 'tpope/vim-sensible'
Plug 'itchyny/vim-gitbranch'

Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" LSP magic
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
colorscheme ayu

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

" omnisharp bindings
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>cl  <Plug>(coc-codelens-action)

augroup ccls_commands
autocmd!

autocmd FileType cpp,h nmap <silent> [g <Plug>(coc-diagnostic-prev)
autocmd FileType cpp,h nmap <silent> ]g <Plug>(coc-diagnostic-next) 

autocmd FileType cpp,h nmap <silent> gd <Plug>(coc-definition)
autocmd FileType cpp,h nmap <silent> gy <Plug>(coc-type-definition)
autocmd FileType cpp,h nmap <silent> gi <Plug>(coc-implementation)
autocmd FileType cpp,h nmap <silent> gr <Plug>(coc-references)

autocmd FileType cpp,h nmap <leader>rn <Plug>(coc-rename)
autocmd FileType cpp,h xmap <leader>f Plug>(coc-format-selected)

autocmd FileType cpp,h nmap <leader>= <Plug>(coc-format-selected)

augroup END

" in millisecond, used for both CursorHold and CursorHoldI,
" use updatetime instead if not defined
let g:cursorhold_updatetime = 100
augroup omnisharp_commands
  autocmd!

  autocmd CursorHoldI *.cs call s:test() 
  autocmd CursorHold *.cs call s:test() 
  "autocmd CursorHold *.cs OmniSharpTypeLookup 
  "autocmd CursorHoldI *.cs execute "normal \<Plug>(omnisharp_signature_help)"

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> gr <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <F2> <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END

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
\ 'RegexOtherEscape': 'Delimiter',
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
-- don't index unncessary files 
require'telescope'.setup({
    defaults = {
        file_ignore_patterns = { "^./.git/", "^node_modules/", "^vendor/", "%.meta",
	"%.asset","%.unity", "%.ttf", "%.png", "%.jpg", "%.prefab", "%.ogg",
	"%.anim", "%.fbx", "%.obj", "%.tga", "%.shader", "%.swcode", "%.mat",
	"%.vfx", "%.FBX", "%.asmdef", "%.controller", "%.dll", "%.TGA",
	"%.file"},
    }
})


require('telescope').load_extension('env')

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = false,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {"csharp", "cs", "rust", "vim"},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF


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

set number

" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree | wincmd p
"autocmd VimEnter * if &modifiable | NERDTreeFind | wincmd p | endif

set splitbelow
let g:SuperTabDefaultCompletionType = "<c-n>"

autocmd VimEnter * :10sp | term
au VimEnter * wincmd w

noremap tn  :tabedit<Space><CR>
nnoremap <leader>lg :lua require('telescope.builtin').live_grep()<CR>
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nmap <Leader>di <Plug>VimspectorBalloonEval
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <F5> :call vimspector#Continue()<CR>

nnoremap <F9> :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

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
nmap <Leader>gd : GBrowse<CR>
nmap <Leader>gr : GV?<CR>

" If you like colors instead
" highlight SignifySignAdd                  ctermbg=green                guibg=#00ff00
" highlight SignifySignDelete ctermfg=black ctermbg=red    guifg=#ffffff guibg=#ff0000
" highlight SignifySignChange ctermfg=black ctermbg=yellow guifg=#000000 guibg=#ffff00
