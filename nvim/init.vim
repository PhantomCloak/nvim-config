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

" Themes
Plug 'Shatur/neovim-ayu' 
Plug 'olimorris/onedarkpro.nvim'
Plug 'junegunn/seoul256.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-tree.lua'

" Code Analaysis & Formatting & Debugging
Plug 'liuchengxu/vim-clap'
Plug 'puremourning/vimspector'

" File & Traveling
Plug 'jremmen/vim-ripgrep'
Plug 'ptzz/lf.vim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'LinArcX/telescope-env.nvim'
Plug 's1n7ax/nvim-terminal'
Plug 'voldikss/vim-floaterm'
Plug 'airblade/vim-rooter'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-gitbranch'
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

 cfg = {
  debug = false, 
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", 
  verbose = false, 
  bind = true, 
  doc_lines = 10, 
  max_height = 12, 
  max_width = 80, 
  wrap = true, 
  floating_window = true, 
  floating_window_above_cur_line = true, 
  floating_window_off_x = 1, 
  floating_window_off_y = 0, 
  close_timeout = 4000, 
  fix_pos = false,  
  hint_enable = false, 
  hi_parameter = "LspSignatureActiveParameter", 
  handler_opts = {
    border = "rounded" 
  },
  always_trigger = false,
  auto_close_after = nil, 
  extra_trigger_chars = {"(",",",", "}, 
  zindex = 200, 
  padding = '', 
  transparency = nil, 
  shadow_blend = 36, 
  shadow_guibg = 'Black', 
  timer_interval = 100, 
  toggle_key = nil, 
  select_signature_key = nil, 
  move_cursor_key = nil, 
}

local telescope = require('telescope')
local nvimtree = require('nvim-tree')

local ayu = require('ayu')
local lualine = require('lualine')

local cmp = require('cmp')
local cmpnvimlsp = require('cmp_nvim_lsp')
local lspconfig = require('lspconfig')
local lspsignature = require('lsp_signature')
local lspformat = require('lsp-format')

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true } 
local api = vim.api

nvimtree.setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
    highlight_opened_files = "icon",
  },
  update_focused_file = {
        enable = true,
        ignore_list = {},
  },
  filters = {
    dotfiles = true,
  },
})

-- Telescope
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

-- LSP Itself
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

lspconfig.omnisharp.setup {
  capabilities = cmpnvimlsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
  cmd = { "/Users/unalozyurt/Downloads/omnisharp-osx-x64-net6.0/OmniSharp", "--languageserver" , "--hostPID", tostring(pid) },
}

-- LSP Signature Help
lspsignature.setup(cfg)

-- LSP Formatter
lspformat.setup {}
lspconfig.gopls.setup { on_attach = lspformat.on_attach }

keymap("n", "gr", ":Telescope lsp_references<CR>", opts)
keymap("n", "gd", ":Telescope lsp_definitions<CR>", opts)

-- Telescope
keymap("n", "<leader>dD", ":Telescope lsp_document_diagnostics<CR>", opts)
keymap("n", "<leader>dW", ":Telescope lsp_workspace_diagnostics<CR>", opts)
keymap("n", "<leader>ca", ":%Telescope lsp_range_code_actions", opts)
keymap("n", "<F3>", ":Telescope find_files<CR>", opts)
keymap("n", "<F4>", ":Telescope live_grep<CR>", opts)
keymap("n", "ff", ":lua require'telescope.builtin'.live_grep({grep_open_files=true})<CR>", opts)

-- LSP
keymap("n", "rn", ":lua lua.vim.lsp.buf.rename()<CR>", opts)
keymap("n", "gr", ":Telescope lsp_references<CR>", opts)

-- Git
keymap("n", "<leader>lg", ":LazyGit<CR>", opts)
keymap("n", "<leader>gb", ":Git blame<CR>", opts)
keymap("n", "<leader>ggb", ":GBrowse<CR>", opts)
keymap("n", "<leader>gv", ":GV?<CR>", opts)

-- Vimspector
keymap("n", "<leader>dd", ":call vimspector#Launch()<CR>", opts)
keymap("n", "<leader>dr", ":call vimspector#Reset<CR>", opts)
keymap("n", "<leader>vp", ":<Plug>vimspectorBalloonEval", opts)
keymap("n", "<leader>ds", ":<Plug>VimspectorStop", opts)
keymap("n", "<F5>", ":call vimspector#Continue<CR>", opts)
keymap("n", "<F10>", "<Plug>VimspectorStepOver", opts)
keymap("n", "<F11>", "<Plug>VimspectorStepInto", opts)
keymap("n", "<F9>", ":call vimspector#ToggleBreakpoint<CR>", opts)

-- api.nvim_create_autocmd("BufRead", { pattern = "*.cs", command = [[nvimtree.toggle(false, true)]] })

-- Global variables

vim.wo.number = true
vim.opt.termguicolors = true

-- Visuals
ayu.setup({
    mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
    overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
})

ayu.colorscheme()

lualine.setup({
  options = {
    theme = 'ayu',
  },
})

EOF

function! s:TeleTab()
    tabedit pwd
    Telescope find_files
endfunction

" Tabs
noremap tn  :call <SID>TeleTab()<CR>


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

" Git
let g:SuperTabDefaultCompletionType = "<c-n>"


set splitbelow


autocmd VimEnter * :10sp | term

au VimEnter * wincmd w

"hi Pmenu        ctermfg=black ctermbg=black gui=NONE guifg=#98fb98 guibg=#6d6d6d  
