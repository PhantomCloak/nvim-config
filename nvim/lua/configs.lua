-- TREE SITTER CONFIG

treeSitterCfg = {
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

-- TREE CONFIG

treeCfg = {
auto_reload_on_write = true,
open_on_setup = true,
open_on_setup_file = true,
open_on_tab = true,
prefer_startup_root = true,
view = {
	centralize_selection = true,
	side = "left",
	preserve_window_proportions = true,
	},
update_focused_file = {
	enable = true
	},
renderer = {
	highlight_git = true,
	highlight_opened_files = "all",
	icons = {
		show = {
			folder_arrow = false,
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
expand_all = {
		max_folder_discovery = 100,
		},
}

-- CONFIG LSP
omnisharpLspCfg = {
	capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	require('nvim-navic').attach(client, bufnr)
	lspformat.on_attach(client)
	end,
	handlers = {
		["textDocument/definition"] = require("omnisharp_extended").handler,
		},
	cmd = { "/Users/unalozyurt/Downloads/omnisharp-osx-arm64-net6.0/OmniSharp", "--languageserver" , "--hostPID", tostring(pid) },
	}

clangdLspCfg = {
	on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
        end
}

-- CONFIG CMP
cmpConfig = {
	appearance = {
		menu = {
			direction = 'below' -- auto or above or below
			}
		},
	formatting = {
		format = require('lspkind').cmp_format({
		mode = 'symbol_text', -- show only symbol annotations
		raxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		})
	},
mapping = {
	['<Tab>'] = require('cmp').mapping.select_next_item(),
	['<S-Tab>'] = require('cmp').mapping.select_prev_item(),
	['<CR>'] = require('cmp').mapping.confirm({behavior = require('cmp').ConfirmBehavior.Replace,select = false})
	},
sources = {
	{ name = 'nvim_lsp' },
	},
preselect = require('cmp').PreselectMode.None
}
   
-- CONFIG LSP SIGNATURE
lspSignatureCfg = {
	log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", 
	bind = true, 
	doc_lines = 2, 
	max_height = 7, 
	max_width = 150, 
	close_timeout = 4000, 
	hint_enable = false, 
	hi_parameter = "LspSignatureActiveParameter", 
	always_trigger = false,
	extra_trigger_chars = {"(",",",", "}, 
}

-- CONFIG NAVIC
navicCfg = {
	highlight = true,
icons = {
		Namespace = " ",
		Class = " ",
		Method = " ",
		Function = " "
	}
}

-- CONFIG TELESSCOPE

telescopeCfg = {
	pickers = {
		lsp_references = {
			theme = "dropdown",
		  },
		lsp_definitions = {
			theme = "dropdown",
		}
	},
	defaults = {
    file_ignore_patterns = { "^./.git/", "^node_modules/", "^vendor/", "%.meta",
        "%.asset","%.unity", "%.ttf", "%.png", "%.jpg", "%.prefab", "%.ogg",
        "%.anim", "%.fbx", "%.obj", "%.tga", "%.shader", "%.swcode", "%.mat",
        "%.vfx", "%.FBX", "%.asmdef", "%.controller", "%.dll", "%.TGA",
        "%.file"},
    },
	extensions = {
		command_palette = {
			{"File",
			  { "entire selection (C-a)", ':call feedkeys("GVgg")' },
			  { "save current file (C-s)", ':w' },
			  { "save all files (C-A-s)", ':wa' },
			  { "quit (C-q)", ':qa' },
			  { "file browser (C-i)", ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
			  { "search word (A-w)", ":lua require('telescope.builtin').live_grep()", 1 },
			  { "git files (A-f)", ":lua require('telescope.builtin').git_files()", 1 },
			  { "files (C-f)",     ":lua require('telescope.builtin').find_files()", 1 },
			},
			{"Help",
			  { "tips", ":help tips" },
			  { "cheatsheet", ":help index" },
			  { "tutorial", ":help tutor" },
			  { "summary", ":help summary" },
			  { "quick reference", ":help quickref" },
			  { "search help(F1)", ":lua require('telescope.builtin').help_tags()", 1 },
			},
			{"Vim",
			  { "reload vimrc", ":source $MYVIMRC" },
			  { 'check health', ":checkhealth" },
			  { "jumps (Alt-j)", ":lua require('telescope.builtin').jumplist()" },
			  { "commands", ":lua require('telescope.builtin').commands()" },
			  { "command history", ":lua require('telescope.builtin').command_history()" },
			  { "registers (A-e)", ":lua require('telescope.builtin').registers()" },
			  { "colorshceme", ":lua require('telescope.builtin').colorscheme()", 1 },
			  { "vim options", ":lua require('telescope.builtin').vim_options()" },
			  { "keymaps", ":lua require('telescope.builtin').keymaps()" },
			  { "buffers", ":Telescope buffers" },
			  { "search history (C-h)", ":lua require('telescope.builtin').search_history()" },
			  { "paste mode", ':set paste!' },
			  { 'cursor line', ':set cursorline!' },
			  { 'cursor column', ':set cursorcolumn!' },
			  { "spell checker", ':set spell!' },
			  { "relative number", ':set relativenumber!' },
			  { "search highlighting (F12)", ':set hlsearch!' },
			}
		  }
	}
}

-- CONFIG LUALINE

lualineCfg = { 
    options = { 
		theme = 'ayu',
		globalstatus = true,
	},
 }
 
-- CONFIG TROUBLE

troubleCfg = {
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

-- CONFIG DAP
dapCCfg = {
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

dapCodeLLDBCfg  = {
	type = 'server',
	host = '127.0.0.1',
	port = 13000
  }

dapReplCfg = {
    exit = { 'q', 'exit' },
    custom_commands = {
        ['.run_to_cursor'] = dap.run_to_cursor,
        ['.restart'] = dap.run_last
    }
}

-- CONFIG DAPUI

dapUiCfg = {
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
  }