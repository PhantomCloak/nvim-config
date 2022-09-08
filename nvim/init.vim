" Plugins will be downloaded under the specified directory.

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged') "Dependencies Plug 'nvim-lua/plenary.nvim' Plug 'tami5/sqlite.lua'
" Quality of life
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'kevinhwang91/nvim-bqf'
Plug 'ten3roberts/qf.nvim'
Plug 'ervandew/supertab'
"Plug 'Pocco81/auto-save.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'romgrk/barbar.nvim'
Plug 'luukvbaal/stabilize.nvim'

" Themes Plug 'Shatur/neovim-ayu' 
Plug 'olimorris/onedarkpro.nvim'
Plug 'junegunn/seoul256.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'folke/trouble.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'Shatur/neovim-ayu' 
Plug 'folke/lsp-colors.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'onsails/lspkind.nvim'
Plug 'yamatsum/nvim-nonicons'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Code Analaysis & Formatting & Debugging
Plug 'liuchengxu/vim-clap'
Plug 'puremourning/vimspector'
Plug 'wfxr/minimap.vim'

" File & Traveling
Plug 'jremmen/vim-ripgrep'
Plug 'ptzz/lf.vim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'LinArcX/telescope-env.nvim'
Plug 'gbrlsnchs/telescope-lsp-handlers.nvim'
Plug 's1n7ax/nvim-terminal'
Plug 'voldikss/vim-floaterm'
Plug 'airblade/vim-rooter'
Plug 'FeiyouG/command_center.nvim'
Plug 'petertriho/nvim-scrollbar'
 
" Git
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-gitbranch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'kdheepak/lazygit.nvim'


" LSP magic
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'ray-x/lsp_signature.nvim'
Plug 'lukas-reineke/lsp-format.nvim'
Plug 'SmiteshP/nvim-navic'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Hoffs/omnisharp-extended-lsp.nvim'

Plug 'nvim-telescope/telescope-vimspector.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

Plug 'MaskRay/ccls'


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

set termguicolors
lua << EOF
--require("scrollbar").setup({})

require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all"
	ensure_installed = { "c", "lua", "rust" },
	sync_install = false,
	auto_install = true,
	ignore_install = { "javascript" },
	textobjects ={
	move = {
		enable = true,
		set_jumps = true,
		goto_next_end = {
			["]]"] = {"@function.outer", "@class.outer"},
			},
		goto_previous_start = {
			["[["] = {"@function.outer", "@class.outer"},
			},
		},
	},
highlight = {
	enable = true,
	additional_vim_regex_highlighting = false,
	},
}

require("mason").setup()
require("lsp-colors").setup({})
require'bufferline'.setup({})
cfg = {
	debug = false, 
	log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", 
	verbose = false, 
	bind = true, 
	doc_lines = 2, 
	max_height = 7, 
	max_width = 150, 
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
	transparency = 100, 
	shadow_blend = 36, 
	shadow_guibg = 'Black', 
	timer_interval = 200, 
	hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
	toggle_key = nil, 
	select_signature_key = nil, 
	move_cursor_key = nil, 
}

require'qf'.setup{}

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
auto_reload_on_write = false,
create_in_closed_folder = false,
open_on_setup = true,
open_on_setup_file = true,
open_on_tab = true,
sort_by = "name",
prefer_startup_root = true,
view = {
	adaptive_size = false,
	centralize_selection = true,
	width = 30,
	height = 30,
	hide_root_folder = false,
	side = "left",
	preserve_window_proportions = false,
	signcolumn = "yes",
	},
update_focused_file = {
	enable = true
	},
renderer = {
	highlight_git = true,
	highlight_opened_files = "all",
	icons = {
		webdev_colors = true,
		git_placement = "before",
		show = {
			file = true,
			folder = true,
			folder_arrow = false,
			git = true,
			},
		glyphs = {
			default = "",
			symlink = "",
			bookmark = "",
			folder = {
				arrow_closed = "",
				arrow_open = "",
				default = "",
				open = "",
				empty = "",
				empty_open = "",
				},
			git = {
				unstaged = "",
				staged = "",
				unmerged = "",
				renamed = "",
				untracked = "",
				deleted = "",
				ignored = "◌",
				},
			},
		},
	},
filters = {
	dotfiles = true,
	custom = {"*.meta"},
	},
git = {
	enable = true,
	ignore = true,
	show_on_dirs = true,
	timeout = 400,
	},
actions = {
	use_system_clipboard = true,
	change_dir = {
		enable = true,
		global = false,
		restrict_above_cwd = false,
		},
	expand_all = {
		max_folder_discovery = 100,
		exclude = {},
		},
	},
}


local telescope = require('telescope')
local nvimtree = require('nvim-tree')

local ayu = require('ayu')
local lualine = require('lualine')
local dressing = require('dressing')

local cmp = require('cmp')
local cmpnvimlsp = require('cmp_nvim_lsp')
local lspconfig = require('lspconfig')
local lspsignature = require('lsp_signature')
local lspformat = require('lsp-format')
local navic = require('nvim-navic')
local trouble = require('trouble')
local bqf = require('bqf');


local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true } 
local api = vim.api

require("stabilize").setup()

navic.setup {
	highlight = true,
	icons = {
		Namespace = " ",
		Class = " ",
		Method = " ",
		Function = " "
		}
	}

bqf.setup()
-- Visuals
trouble.setup {
	mode = "document_diagnostics",
	auto_fold = false,
	padding = false,
	auto_open = true,
	auto_close = false,
	auto_jump = {},
	use_diagnostic_signs = false,
	icons = true,
	auto_preview = false,
	}

dressing.setup({})
ayu.setup({
mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
})
ayu.colorscheme()

lualine.setup({ options = { theme = 'ayu', }, })


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
telescope.load_extension('command_center')
telescope.load_extension('lsp_handlers')
telescope.load_extension('vimspector')


-- LSP Itself
local lspkind = require('lspkind')

cmp.setup {
	appearance = {
		menu = {
			direction = 'below' -- auto or above or below
			}
		},
	formatting = {
		format = lspkind.cmp_format({
		mode = 'symbol_text', -- show only symbol annotations
		raxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		})
	},
mapping = {
	['<Tab>'] = cmp.mapping.select_next_item(),
	['<S-Tab>'] = cmp.mapping.select_prev_item(),
	['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace,select = false})
	},
sources = {
	{ name = 'nvim_lsp' },
	},
preselect = cmp.PreselectMode.None
}


require"nvim-tree.view".View.winopts.cursorline = true

lspformat.setup {}


lspconfig.omnisharp.setup {
	capabilities = cmpnvimlsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	navic.attach(client, bufnr)
	lspformat.on_attach(client)
	end,
	handlers = {
		["textDocument/definition"] = require('omnisharp_extended').handler,
		},
	cmd = { "/Users/unalozyurt/Downloads/omnisharp-osx-arm64-net6.0/OmniSharp", "--languageserver" , "--hostPID", tostring(pid) },
	}


lspconfig.clangd.setup{
	on_attach = function(client, bufnr)
	navic.attach(client, bufnr)
	end
}







local dap = require('dap')
local dapui = require('dapui')


dap.adapters.codelldb = {
  type = 'server',
  host = '127.0.0.1',
  port = 13000
}
dap.configurations.c = {
    {
        type = "codelldb",
        request = "launch",
        cwd = '${workspaceFolder}',
        terminal = 'integrated',
        console = 'integratedTerminal',
        stopOnEntry = false,
        program = function()
            return vim.fn.input('executable: ', vim.fn.getcwd() .. '/', 'file')
        end
    }
}


dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.cpp
-- repl setup
dap.repl.commands = vim.tbl_extend('force', dap.repl.commands, {
    exit = { 'q', 'exit' },
    custom_commands = {
        ['.run_to_cursor'] = dap.run_to_cursor,
        ['.restart'] = dap.run_last
    }
})





local omni_extend = require('omnisharp_extended');

-- LSP Signature Help
lspsignature.setup(cfg)
keymap("n", "gr", ":Telescope lsp_references<CR>", opts)

--keymap("n", "gd",":lua require('omnisharp_extended').telescope_lsp_definitions()<CR>", opts)
keymap("n", "gd",":Telescope lsp_definition<CR>", opts)


-- Telescope
keymap("n", "<leader>dD", ":Telescope lsp_document_diagnostics<CR>", opts)
keymap("n", "<leader>dW", ":Telescope lsp_workspace_diagnostics<CR>", opts)
keymap("n", "<leader>ca", ":%Telescope lsp_range_code_actions", opts)
keymap("n", "<F3>", ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<CR>", opts)
keymap("n", "<F4>", ":Telescope live_grep<CR>", opts)
keymap("n", "ff", ":lua require'telescope.builtin'.live_grep({grep_open_files=true})<CR>", opts)
keymap("n", "tn", ":tabedit "..  vim.fn.getcwd() .."| Telescope find_files<CR>", opts)

-- LSP
keymap("n", "rn", ":lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "gr", ":Telescope lsp_references<CR>", opts)

keymap("n", "<leader>co",":lua vim.lsp.buf.code_action()<CR>", opts)

-- Git
keymap("n", "<leader>lg", ":LazyGit<CR>", opts)
keymap("n", "<leader>gb", ":Git blame<CR>", opts)
keymap("n", "<leader>ggb", ":GBrowse<CR>", opts)
keymap("n", "<leader>gv", ":GV?<CR>", opts)
keymap("n", "<leader>gs", ":Gdiffsplit!<CR>", opts)


-- Vimspector
keymap("n", "<leader>dd", ":call vimspector#Launch()<CR>", opts)
keymap("n", "<leader>dr", ":call vimspector#Reset<CR>", opts)
keymap("n", "<leader>bb", ":<Plug>vimspectorBalloonEval", opts)
keymap("n", "<leader>ds", ":<Plug>VimspectorStop", opts)
keymap("n", "<F5>", ":call vimspector#Continue<CR>", opts)
keymap("n", "<F10>", "<Plug>VimspectorStepOver", opts)
keymap("n", "<F11>", "<Plug>VimspectorStepInto", opts)
keymap("n", "<F9>", ":call vimspector#ToggleBreakpoint<CR>", opts)
keymap("n", "<leader>fc", ":Telescope command_center<CR>", opts)

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "rr", ":q<CR>", opts)

--keymap('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
--keymap('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

vim.api.nvim_set_hl(0, "NavicText",{default = false, bg = "#1f2430", fg = "#73d0ff"})
vim.api.nvim_set_hl(0, "NavicIconsMethod",{default = false, bg = "#1f2430", fg = "#c078b8"})
vim.api.nvim_set_hl(0, "NavicIconsClass",{default = false, bg = "#1f2430", fg = "#c078b8"})
vim.api.nvim_set_hl(0, "NavicIconsNamespace",{default = false, bg = "#1f2430", fg = "#c078b8"})

vim.o.signcolumn = 'yes:2'

--keymap('n', '<C-,>', '<Cmd>BufferPrevious<CR>', opts)
keymap('n', '<C-.>', '<Cmd>BufferNext<CR>', opts)
vim.wo.number = true
vim.opt.termguicolors = true

vim.diagnostic.config({virtual_text = {prefix = '🦀'}}) 
require("nvim-autopairs").setup {}
EOF

let g:SuperTabDefaultCompletionType = "<c-n>"

set title titlestring=🦊\ %(%{expand(\"%:~:.:h\")}%)/%t\ -\ NVim\ 🦊

set tabstop=4
set shiftwidth=4
set laststatus=3

let g:minimap_width = 10
autocmd BufEnter *.cs :call timer_start(200, { tid -> execute('Minimap')})
autocmd BufEnter *.cpp :call timer_start(200, { tid -> execute('Minimap')})
highlight ScrollbarHandle guibg=#FFFFFF guifg=0x000000 
let g:netrw_bufsettings = 'noma nomod nonu nowrap ro buflisted' 

nnoremap <silent>  <C-n> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <C-m> <Cmd>BufferNext<CR>
nnoremap <silent>    <C-c> <Cmd>BufferClose<CR>

let g:lightline={ 'enable': {'statusline': 1, 'tabline': 0} }
let g:neovide_cursor_animation_length=0
let g:neovide_cursor_trail_length=0

