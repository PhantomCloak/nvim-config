vim.opt.termguicolors = true
vim.o.signcolumn = 'yes:1'
vim.wo.number = true
vim.o.cmdheight = 0
vim.o.pumheight = 15
vim.o.cinkeys = '0{,0},0),0#,!^F,o,O,e.'
vim.o.wrap = false
vim.opt.termguicolors = true
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.smartindent = true
vim.opt.lazyredraw = true
vim.o.backspace = 'indent,eol,start'

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.undofile = true
vim.o.undodir = os.getenv('HOME') .. '/.cache/nvim'
vim.o.undolevels = 10000

vim.o.directory = os.getenv('HOME') .. '/.cache/nvim'
vim.o.backup = true
vim.o.backupdir = os.getenv('HOME') .. '/.cache/nvim'

vim.o.scrolloff = 12

--vim.g.mapleader = " " 
--vim.g.maplocalleader = "\\" 

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"


function getMonoPath()
    local f = assert(io.popen('which mono', 'r')) local s = assert(f:read('*a'))
    f:close()
    s = s:gsub('^%s*(.-)%s*$', '%1') -- trim
    if s == '' then
        return nil
    end
    return s
end

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  "nvim-treesitter/nvim-treesitter-context",
  "folke/which-key.nvim",
  {"rockyzhang24/arctic.nvim", dependencies  = {"rktjmp/lush.nvim"}, commit = '061ac5c34dbe3ee0efd1dae81cb85bd8469ad772'},
  "Mofiqul/vscode.nvim",
  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",
  {"junegunn/fzf", commit = 'e352b6887849cb6c3c8ae1d98ed357f94273e90a'},
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  {"junegunn/fzf.vim", commit = 'f6cb5b17897ff0c38f60fecd4b529678bcfec259'},
  "jremmen/vim-ripgrep",
  "yamatsum/nvim-nonicons",
  "windwp/nvim-autopairs",
  "famiu/bufdelete.nvim",
  "lewis6991/gitsigns.nvim",
  "tpope/vim-fugitive",
  "Decodetalkers/csharpls-extended-lsp.nvim",
  "ten3roberts/qf.nvim",
  "ojroques/nvim-lspfuzzy",
  {"akinsho/bufferline.nvim", version = "*", event = "BufReadPre", dependencies = "nvim-tree/nvim-web-devicons"},
  "kyazdani42/nvim-tree.lua",
  "stevearc/dressing.nvim",
  "nvim-lualine/lualine.nvim",
  "kevinhwang91/nvim-bqf",
  "kdheepak/lazygit.nvim",
  "tpope/vim-rhubarb",
  "itchyny/vim-gitbranch",
  "neovim/nvim-lspconfig",
  --{"ray-x/lsp_signature.nvim", commit="1fba8f477b8c65add5e07cda0504cf7f81a9a4ab"},
  {"ray-x/lsp_signature.nvim"},
  {"pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim" }},
  "nvim-neotest/nvim-nio",
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "onsails/lspkind.nvim",
  "stevearc/conform.nvim",
  "lukas-reineke/lsp-format.nvim",
  "Hoffs/omnisharp-extended-lsp.nvim",
  "hrsh7th/vscode-langservers-extracted",
  "windwp/nvim-ts-autotag",
  "folke/trouble.nvim",
  {"folke/persistence.nvim", event = "BufReadPre",  opts = {
	  dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/")
  }},
})

-- ==============================================================================

require('trouble').setup()
require('gitsigns').setup()
require("nvim-autopairs").setup();
require("bqf").setup()
require("qf").setup()
require("dressing").setup()
require("lspfuzzy").setup()

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
	typescriptreact = { "prettier" },
	typescript = { "prettier" },
    cpp = { "clang-format" },
	cs = { "csharpier" },
  },
})


-- ==============================================================================

vim.api.nvim_create_autocmd("BufRead", {
  pattern = {"*.vs", "*.vert", "*.fs", "*.frag"},
  callback = function()
    vim.bo.filetype = 'glsl'
  end
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = {"*.hlsl" },
  callback = function()
    vim.bo.filetype = 'hlsl'
  end
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = {"*.wgsl" },
  callback = function()
    vim.bo.filetype = 'wgsl'
  end
})

require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "lua", "markdown_inline" },
    sync_install = false,
    auto_install = true,
    textobjects = {
        move = {
            enable = false,
            set_jumps = true,
            goto_next_end = {
                ["]]"] = "@function.outer",
            },
            goto_previous_start = {
                ["[["] = "@function.outer",
            },
        },
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    filetype_extensions = {
    glsl = { "vs", "vert", "fs", "fragment" },
  },
})

require"nvim-tree.view".View.winopts.cursorline = true
require('nvim-tree').setup({
    open_on_tab = true,
    prefer_startup_root = true,
    view = {
        centralize_selection = true,
        side = "left",
        width = 35,
        preserve_window_proportions = true,
    },
    update_focused_file = {
        enable = true
    },
    renderer = {
        icons = {
            show = {
                folder_arrow = true,
                file = false,
                git = false
            },
            glyphs = {
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                },
           },
        },
    },
    filters = {
        dotfiles = true,
        custom = { "*.meta" },
    },
    git = {
        enable = false
    },
})

require("bufferline").setup({
    options = {
        separator_style = "slant",
        close_icon = '',
        show_tab_indicators = false,
        enforce_regular_tabs = true,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                highlight = "Directory",
                padding = 1
            }
        },
    },
    highlights = {
        separator_selected = {
            fg = "#252526",
            bg = "#1e1e1e"
        },
    },
})

-- ==============================================================================

local cmp = require("cmp")
require("typescript-tools").setup {
  settings = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    expose_as_code_action = {},
    tsserver_path = nil,
    tsserver_plugins = {},
    tsserver_max_memory = "auto",
    tsserver_format_options = {},
    tsserver_file_preferences = {},
    complete_function_calls = false,
    include_completions_with_insert_text = true,
  },
}


cmp.setup({
    appearance = {
        menu = {
            direction = 'below'
        }
    },
    formatting = {
        format = require("lspkind").cmp_format({
            mode = 'symbol_text', 
            maxwidth = 50,
        })
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true })
    }),
    sources = {
        { name = 'nvim_lsp' },
    },
    preselect = cmp.PreselectMode.None
})

local lspconfig = require("lspconfig")
lspconfig.omnisharp.setup({
    use_mono = true,
     root_dir = function(fname)    
        return vim.loop.cwd()
    end,
    handlers = {
        ["textDocument/definition"] = require("omnisharp_extended").handler,
    },
    cmd = { os.getenv('HOME') .. "/.OmniSharp/OmniSharp", "--languageserver", "--hostPID", tostring(pid) },
    omnisharp = {
        useModernNet = false,
        monoPath = getMonoPath()
    }
})

lspconfig.clangd.setup({ cmd = { "clangd", "--offset-encoding=utf-16", }, } )
lspconfig.pyright.setup{}
lspconfig.gopls.setup{}
lspconfig.tsserver.setup {}

require("lsp_signature").setup({
    bind = true,
    doc_lines = 2,
    floating_window_above_cur_line = trutrue,
    max_height = 3,
    max_width = 150,
    close_timeout = 1500,
    hint_enable = false,
    hi_parameter = "LspSignatureActiveParameter",
    handler_opts = {
        border = "shadow"
    },
    always_trigger = false,
    extra_trigger_chars = { "(", ",", ", " },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

require('nvim-ts-autotag').setup({})


-- ==============================================================================

-- Setup LSP
require 'debugger'
-- Setup Tools
require 'prompt'
-- Setup Plugins & Keymaps & Vim Options
require 'keymaps'

require("lualine").setup({
    options = {
        theme = 'codedark',
        globalstatus = true,
    },
    sections = {
        lualine_x = { '', 'searchcount', 'selectioncount' },
		lualine_c = {{'filename',path = 1,}}
    },
})

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

vim.api.nvim_set_hl(0, "TreesitterContext",{default = false, bg = "#363c4c"})
vim.api.nvim_set_hl(0, "TreesitterContext",{default = false, bg = "#363c4c"})

vim.api.nvim_set_hl(0, "NavicText",{default = true, bg = "#1f2430", fg = "#73d0ff"})
vim.api.nvim_set_hl(0, "NavicIconsMethod",{default = true, bg = "#1f2430", fg = "#c078b8"})
vim.api.nvim_set_hl(0, "NavicIconsClass",{default = true, bg = "#1f2430", fg = "#c078b8"})
vim.api.nvim_set_hl(0, "NavicIconsNamespace",{default = true, bg = "#1f2430", fg = "#c078b8"}) 


vim.cmd([[
colorscheme vscode
hi BufferLineBackground guifg=#9c9c9c guibg=#646464 
hi BufferLineSeparator guifg=#252526 guibg=#646464 
hi BufferLineCloseButton guifg=#9c9c9c guibg=#646464 
hi BufferLineDevIconLua guibg=#646464
hi BufferLineDevIconCs guibg=#646464
hi BufferLineDevIconCpp guibg=#646464
hi BufferLineDevIconDefault guibg=#646464
hi BufferLineDevIconJson guibg=#646464
hi BufferLineDevIconH guibg=#646464
hi BufferLineDevIconDockerfile guibg=#646464
hi BufferLineDevIconHeader guibg=#646464
hi BufferLineDevIconJson guibg=#646464
hi BufferLineFill guibg=#252526
hi debugPC guibg=#424218
set signcolumn=number
set clipboard+=unnamedplus
]])


--vim.api.nvim_set_keymap("n", "Z", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})

--vim.api.nvim_set_keymap("n", "<leader>zz", [[<cmd>lua require("persistence").load()<cr>]], {})
--vim.api.nvim_set_keymap("n", "<leader>zz", [[<cmd>lua require("persistence").load()<cr>:NvimTreeOpen<cr>]], {})
vim.api.nvim_set_keymap("n", "<leader>zz", [[<cmd>lua require("persistence").load()<cr>:NvimTreeOpen<cr>]], {})



keymap("n", "<leader>dd", "<cmd>lua dap_ll()<CR>", opts)
keymap("n", "<leader>dt", "<cmd>lua dap_tt()<CR>", opts)
keymap("n", "<F5>", ":DapContinue<CR>", opts)
keymap("n", "<F9>", ":DapToggleBreakpoint<CR>", opts)
keymap("n", "<F10>", ":DapStepOver<CR>", opts)
keymap("n", "<F11>", ":DapStepInto<CR>", opts)
keymap("n", "K", ":lua require(\"dapui\").eval()<CR>", opts)

function dap_tt()
    vim.cmd('DapTerminate')  
    vim.cmd("lua require('dapui').close()")
    vim.cmd('NvimTreeOpen')  
end

function dap_ll()
    vim.cmd('NvimTreeClose')  
    vim.cmd("lua require('dapui').open()")
    vim.cmd('DapContinue')  
end

log_level = vim.log.levels.DEBUG

local function open_nvim_tree(data)

  -- buffer is a real file on the disk
  local real_file = vim.fn.filereadable(data.file) == 1

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  if not real_file and not no_name then
    return
  end

  -- open the tree, find the file but don't focus it
  require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
