" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Dependencies
Plug 'nvim-lua/plenary.nvim'

" Quality of life
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'wellle/targets.vim'
Plug 'antoinemadec/FixCursorHold.nvim'

" Themes
Plug 'ayu-theme/ayu-vim' 
Plug 'olimorris/onedarkpro.nvim'
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'
"Plug 'ryanoasis/vim-devicons' " Poor performance

" Code Analaysis & Formatting & Debugging
Plug 'dense-analysis/ale'
Plug 'liuchengxu/vim-clap'
Plug 'puremourning/vimspector'

" File & Traveling
Plug 'jremmen/vim-ripgrep'
Plug 'ptzz/lf.vim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'LinArcX/telescope-env.nvim'
Plug 's1n7ax/nvim-terminal'
Plug 'preservim/nerdtree'
Plug 'voldikss/vim-floaterm'
Plug 'airblade/vim-rooter'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-gitbranch'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'kdheepak/lazygit.nvim'


" LSP magic
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'ray-x/lsp_signature.nvim'
Plug 'lukas-reineke/lsp-format.nvim'

Plug 'MaskRay/ccls'
Plug 'OmniSharp/omnisharp-vim'


if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction

  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
endif

call plug#end()

" show command pop-up
call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_palette_theme({
      \ 'border': 'rounded',
      \ 'max_height': '75%',
      \ 'min_height': 0,
      \ 'prompt_position': 'top',
      \ 'reverse': 0,
      \ })))

call wilder#setup({'modes': [':', '/', '?']})
if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  set completepopup=highlight:Pmenu,border:off
endif

lua << EOF

local telescope = require('telescope')

telescope.setup({
    defaults = {
        file_ignore_patterns = { "^./.git/", "^node_modules/", "^vendor/", "%.meta",
	"%.asset","%.unity", "%.ttf", "%.png", "%.jpg", "%.prefab", "%.ogg",
	"%.anim", "%.fbx", "%.obj", "%.tga", "%.shader", "%.swcode", "%.mat",
	"%.vfx", "%.FBX", "%.asmdef", "%.controller", "%.dll", "%.TGA",
	"%.file"},
    }
})

telescope.load_extension('env')

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
  verbose = false, -- show debug line number
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
  max_height = 12, -- max height of signature floating_window
  max_width = 80, -- max_width of signature floating_window
  wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
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
  extra_trigger_chars = {"(",",",", "}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc
  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 100, -- default timer check interval set to lower value if you want to reduce latency
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
keymap("n", "<leader>lg", "LazyGit", opts)
EOF


function! s:TeleTab()
    tabedit pwd
    Telescope find_files
endfunction

" Telescope
nnoremap <F3> :Telescope find_files<cr>
nnoremap <F4> :Telescope live_grep<cr>
nnoremap <leader>ff :lua require'telescope.builtin'.live_grep({grep_open_files=true})<cr>
nnoremap <leader>lg :LazyGit<CR>

" Tabs
noremap tn  :call <SID>TeleTab()<CR>

" Vimspector
noremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>di <Plug>VimspectorBalloonEval
nnoremap <F5> :call vimspector#Continue()<CR>

nnoremap <F9> :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dt<Plug>VimspectorStop
nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
nmap <Leader> do <Plug>VimspectorStepOver

" Git
nmap <Leader>gb : Git blame<CR>
nmap <Leader>gbb : GBrowse<CR>
nmap <Leader>gh : GV?<CR>

nmap <Leader>gb : Git blame<CR>
nmap <Leader>gbb : GBrowse<CR>
nmap <Leader>gh : GV?<CR>

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
	    \ 'colorscheme': 'PaperColor',
	    \ 'active': {
		\   'left': [ [ 'mode', 'paste' ],
		\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
		\ },
		\ 'component_function': {
		    \   'gitbranch': 'gitbranch#name'
		    \ },
		    \ }


" Omngisharp & Telescope
let g:OmniSharp_selector_ui = 'telescope' 
let g:OmniSharp_selector_findusages = 'telescope'

" ALE and CursorFix
let g:ale_linters = { 'cs': ['OmniSharp'] }
let g:cursorhold_updatetime = 100

" Git
let g:SuperTabDefaultCompletionType = "<c-n>"

let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 0

" Nerd Tree
let NERDTreeMinimalUI=1

set termguicolors     " enable true colors support
set shiftwidth=4
set splitbelow
set number

colorscheme desert

autocmd BufRead *.cs NERDTreeFind | wincmd w
autocmd BufRead *.cs NERDTreeFind | wincmd w | echomsg "asda"

autocmd VimEnter * :10sp | term
au VimEnter * wincmd w

hi Pmenu        ctermfg=black ctermbg=black gui=NONE guifg=#98fb98 guibg=#6d6d6d  
