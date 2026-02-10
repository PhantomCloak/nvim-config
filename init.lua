----------------------------------------------------------------------
-- UTILS
----------------------------------------------------------------------

local function getMonoPath()
    local f = assert(io.popen("which mono", "r"))
    local s = assert(f:read("*a"))
    f:close()
    s = s:gsub("^%s*(.-)%s*$", "%1")
    if s == "" then return nil end
    return s
end

vim.cmd([[
hi Type guifg=#1e76ed
function! IndentWithI()
  if len(getline('.')) == 0
    return "\"_cc"
  else
    return "i"
  endif
endfunction
nnoremap <expr> i IndentWithI()
]])

----------------------------------------------------------------------
-- OPTIONS
----------------------------------------------------------------------

vim.opt.termguicolors = true
vim.opt.lazyredraw = true

vim.wo.number = true

vim.o.signcolumn = "yes:1"
vim.o.cmdheight = 0
vim.o.pumheight = 15
vim.o.cinkeys = "0{,0},0),0#,!^F,o,O,e."

vim.o.wrap = false
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

vim.o.smartindent = true
vim.o.backspace = "indent,eol,start"

vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.clipboard = "unnamedplus"
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.cache/nvim"
vim.o.undolevels = 10000

vim.o.directory = os.getenv("HOME") .. "/.cache/nvim"
vim.o.backup = true
vim.o.backupdir = os.getenv("HOME") .. "/.cache/nvim"

vim.o.scrolloff = 12

vim.opt.list = true
vim.opt.listchars = {tab = "→ ", trail = "·", extends = ">", precedes = "<", nbsp = "␣"}

----------------------------------------------------------------------
-- LAZY.NVIM
----------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    "nvim-treesitter/nvim-treesitter-context",
    "Mofiqul/vscode.nvim",
    "kyazdani42/nvim-web-devicons",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "mrjones2014/smart-splits.nvim",
    "jremmen/vim-ripgrep",
    "yamatsum/nvim-nonicons",
    "windwp/nvim-autopairs",
    "famiu/bufdelete.nvim",
    "lewis6991/gitsigns.nvim",
    "tpope/vim-fugitive",
    "ten3roberts/qf.nvim",
    "kyazdani42/nvim-tree.lua",
    "stevearc/dressing.nvim",
    "nvim-lualine/lualine.nvim",
    "kevinhwang91/nvim-bqf",
    "kdheepak/lazygit.nvim",
    "tpope/vim-rhubarb",
    "itchyny/vim-gitbranch",
    "Decodetalkers/csharpls-extended-lsp.nvim",
    "ojroques/nvim-lspfuzzy",
    "neovim/nvim-lspconfig",
    "ray-x/lsp_signature.nvim",
    "onsails/lspkind.nvim",
    "Hoffs/omnisharp-extended-lsp.nvim",
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "stevearc/conform.nvim",
    "hrsh7th/vscode-langservers-extracted",
    "windwp/nvim-ts-autotag",
    "folke/trouble.nvim",
    "mfussenegger/nvim-lint",
    "williamboman/mason.nvim",
    "nvim-lua/plenary.nvim",
    "kwkarlwang/bufresize.nvim",
    {"junegunn/fzf"},
    {"junegunn/fzf.vim"},
    {
        "rockyzhang24/arctic.nvim",
        dependencies = {"rktjmp/lush.nvim"},
        commit = "061ac5c34dbe3ee0efd1dae81cb85bd8469ad772"
    },
    {"pmizio/typescript-tools.nvim", dependencies = {"nvim-lua/plenary.nvim"}},
    {"zadirion/Unreal.nvim", dependencies = {"tpope/vim-dispatch"}},
    {"akinsho/bufferline.nvim", version = "*", event = "BufReadPre", dependencies = "nvim-tree/nvim-web-devicons"},
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = { dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/") }
    },
    {"saghen/blink.cmp", lazy = false, version = "v0.*"},
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = true,
        keys = {
            { "<leader>a", nil, desc = "AI/Claude Code" },
            { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
            { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
            { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
            { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
            {
                "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
            },
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
        },
    }
})

----------------------------------------------------------------------
-- PLUGIN SETUP
----------------------------------------------------------------------

require("mason").setup()
require("trouble").setup()
require("gitsigns").setup()
require("nvim-autopairs").setup()
require("bqf").setup()
require("qf").setup()
require("dressing").setup()
require("bufresize").setup()
require("nvim-ts-autotag").setup()
require("claudecode").setup()

require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ["<S-Tab>"] = {"select_prev", "fallback"},
        ["<Tab>"] = {"select_next", "fallback"},
        ["<CR>"] = {"accept", "fallback"}
    },
    sources = { default = { 'lsp', 'path' } },
    completion = {
        list = { selection = { preselect = true, auto_insert = true } },
    },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono"
    }
})

require("smart-splits").setup({
    resize_mode = {
        hooks = { on_leave = require("bufresize").register }
    }
})

require("conform").setup({
    formatters_by_ft = {
        lua = {"stylua"},
        typescriptreact = {"prettier"},
        typescript = {"prettier"},
        cpp = {"clang-format"},
        cs = {"csharpier"}
    }
})

require("lint").linters_by_ft = {
    markdown = {"vale"},
    typescript = {"eslint_d"},
    typescriptreact = {"eslint_d"}
}

require("nvim-treesitter.configs").setup({
    ensure_installed = {"c", "lua", "markdown_inline", "go"},
    sync_install = false,
    auto_install = true,
    textobjects = {
        move = {
            enable = false,
            set_jumps = true,
            goto_next_end = { ["]]"] = "@function.outer" },
            goto_previous_start = { ["[["] = "@function.outer" }
        }
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    filetype_extensions = {
        glsl = {"vs", "vert", "fs", "fragment"}
    }
})

require("nvim-tree.view").View.winopts.cursorline = true
require("nvim-tree").setup({
    open_on_tab = true,
    prefer_startup_root = true,
    view = {
        centralize_selection = true,
        side = "left",
        width = 35,
        preserve_window_proportions = true
    },
    update_focused_file = { enable = true },
    renderer = {
        indent_width = 1,
        icons = {
            show = { folder_arrow = true, file = false, git = false },
            glyphs = {
                folder = { arrow_closed = "", arrow_open = "" }
            }
        }
    },
    filters = { dotfiles = false, custom = {"*.meta"} },
    git = { enable = false }
})

require("bufferline").setup({
    options = {
        separator_style = "slant",
        mode = "tabs",
        close_icon = "",
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
        }
    },
    highlights = {
        separator_selected = { fg = "#252526", bg = "#1e1e1e" }
    }
})

require("lualine").setup({
    options = { theme = "codedark", globalstatus = true },
    sections = {
        lualine_x = { "", "searchcount", "selectioncount" },
        lualine_c = { { "filename", path = 1 } },
    },
})

require("lspfuzzy").setup({
    methods = 'all',
    jump_one = true,
    save_last = true,
    fzf_preview = { 'right:+{2}-/2:noborder' },
    fzf_modifier = ':~:',
})

----------------------------------------------------------------------
-- FZF
----------------------------------------------------------------------

vim.cmd([[
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal' } }

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
let $FZF_DEFAULT_COMMAND = 'rg -F --files --hidden'
let $FZF_DEFAULT_OPTS = '--bind tab:down,shift-tab:up'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=never --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg -g "*" --column --line-number --no-heading --color=always --smart-case %s | sed "s/ \{1,\}/ /g" || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command, '--with-nth=..4']}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
]])

----------------------------------------------------------------------
-- LSP
----------------------------------------------------------------------

require("typescript-tools").setup({
    settings = {
        publish_diagnostic_on = "insert_leave",
        complete_function_calls = false,
        include_completions_with_insert_text = true,
    },
})

local lspconfig = require("lspconfig")
local capabilities = require("blink.cmp").get_lsp_capabilities()

local servers = {
    omnisharp = {
        use_mono = true,
        root_dir = vim.loop.cwd,
        handlers = {
            ["textDocument/definition"] = require("omnisharp_extended").handler,
        },
        cmd = {
            os.getenv("HOME") .. "/.OmniSharp/OmniSharp",
            "--languageserver", "--hostPID", "--stdio",
            tostring(vim.fn.getpid()),
        },
        omnisharp = {
            useModernNet = false,
            monoPath = getMonoPath(),
        },
    },
    clangd = {
        cmd = { "clangd", "--offset-encoding=utf-16", "--query-driver=**/em++,**/clang*" },
    },
    html = {},
    pyright = { filetypes = {"python"} },
    gopls = {},
}

for name, config in pairs(servers) do
    config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
    lspconfig[name].setup(config)
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            client.request = require('lspfuzzy').wrap_request(client.request)
        end
    end
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        local kopts = { noremap = true, silent = true }
        vim.keymap.set("n", "<leader>co", vim.lsp.buf.code_action, kopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, kopts)
        vim.keymap.set("n", "rn", vim.lsp.buf.rename, kopts)

        local clients = vim.lsp.buf_get_clients(0)
        for _, client in pairs(clients) do
            if client.name == 'omnisharp' then
                vim.keymap.set('n', 'gd', ":lua require('omnisharp_extended').lsp_definitions()<CR>", kopts)
                vim.keymap.set('n', 'gj', ":lua require('csharpls_extended').lsp_definitions()<CR>", kopts)
                vim.opt.softtabstop = 4
                vim.opt.tabstop = 4
                vim.opt.shiftwidth = 4
            elseif client.name == 'clangd' then
                vim.opt.softtabstop = 2
                vim.opt.tabstop = 2
                vim.opt.shiftwidth = 2
                vim.keymap.set("n", "m", ":ClangdSwitchSourceHeader<CR>", kopts)
            elseif client.name == 'tsserver' then
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, kopts)
            end
        end
    end,
})

----------------------------------------------------------------------
-- DAP
----------------------------------------------------------------------

local dap = require('dap')
local dapui = require('dapui')

dap.adapters.unity = {
    type = 'executable',
    command = getMonoPath(),
    args = { os.getenv('HOME') .. '/.UnityDbg/bin/UnityDebug.exe' }
}

dap.configurations.cs = {
    {
        type = 'unity',
        request = 'attach',
        name = 'Unity Editor',
        program = function() return end,
    }
}

dap.repl.commands = vim.tbl_extend('force', dap.repl.commands, {
    exit = { 'q', 'exit' },
    custom_commands = {
        ['.run_to_cursor'] = dap.run_to_cursor,
        ['.restart'] = dap.run_last
    }
})

dap.adapters.codelldb = {
    type = 'server',
    host = '127.0.0.1',
    port = 13000,
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

dap.adapters.firefox = {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/Developer/vscode-firefox-debug/dist/adapter.bundle.js'},
}

dap.configurations.typescript = {
    {
        name = 'Debug with Firefox',
        type = 'firefox',
        request = 'launch',
        reAttach = true,
        url = 'http://localhost:5173/map.html',
        webRoot = '${workspaceFolder}/www',
        firefoxExecutable = '/usr/bin/firefox'
    }
}

dapui.setup({
    expand_lines = true,
    mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "K",
        toggle = "t",
    },
    layouts = {
        {
            elements = { "breakpoints", "stacks", "watches" },
            size = 50,
            position = "left",
        },
        {
            elements = {
                { id = "console", size = 0.50 },
                { id = "scopes", size = 0.50 },
            },
            size = 0.25,
            position = "bottom",
        },
    },
    windows = { indent = 1 },
    render = { max_type_length = nil, max_value_lines = 100 }
})

local ok, godot = pcall(require, "godot")
if ok then
    godot.setup({
        bin = "/Users/ph4nt0m/Downloads/Godot_mono.app/Contents/MacOS/Godot",
    })
end

----------------------------------------------------------------------
-- KEYMAPS
----------------------------------------------------------------------

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Window navigation
keymap("n", "<M-h>", "<C-w>h", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Window resize
vim.keymap.set("n", "<C-.>", function() require('smart-splits').resize_right() end, opts)
vim.keymap.set("n", "<C-,>", function() require('smart-splits').resize_left() end, opts)
vim.keymap.set("n", "<C-=>", function() require('smart-splits').resize_up() end, opts)
vim.keymap.set("n", "<C-->", function() require('smart-splits').resize_down() end, opts)

-- Diagnostics
keymap("n", "??", [[<cmd>lua require("trouble").toggle({ mode = "diagnostics", filter = { buf = vim.fn.bufnr() } })<CR>]], opts)
keymap("n", "<leader>tt", ":lua require('trouble').toggle({mode = 'diagnostics', filter = { severity = vim.diagnostic.severity.ERROR }})<CR>", opts)

-- Buffers / Tabs
keymap("n", "<C-n>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<C-m>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<C-c>", ":bdelete<CR>", opts)
keymap("n", "vp", ":BufferPick<CR>", opts)

-- Terminal
keymap("n", "tt", ":below split | resize 20 | term<CR>", opts)
keymap("n", "rr", ":q<CR>", opts)

-- Format
vim.keymap.set("v", "f", function() require('conform').format() end, opts)

-- Search
keymap("n", "ff", ":FZF<CR>", opts)
keymap("n", "vv", ":RG<CR>", opts)

-- Git
keymap("n", "<leader>lg", ":LazyGit<CR>", opts)
keymap("n", "<leader>gb", ":Git blame<CR>", opts)
keymap("n", "<leader>ggb", ":GBrowse<CR>", opts)
keymap("n", "<leader>gv", ":GV?<CR>", opts)
keymap("n", "<leader>gp", ":Gitsign previw_hunk<CR>", opts)
keymap("n", "<leader>gr", ":Gitsign undo_stage_hunk<CR>", opts)

vim.keymap.set("n", "<leader>gs", function()
    vim.cmd("NvimTreeClose")
    vim.cmd("Gitsign diffthis")
end, opts)

-- LSP navigation
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', '<C-x>', ':belowright sp<CR>:lua vim.lsp.buf.definition()<CR>', opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

-- DAP
local function dap_start()
    vim.cmd("NvimTreeClose")
    dapui.open()
    vim.cmd("DapContinue")
end

local function dap_stop()
    vim.cmd("DapTerminate")
    dapui.close()
    vim.cmd("NvimTreeOpen")
end

vim.keymap.set("n", "<leader>dd", dap_start, opts)
vim.keymap.set("n", "<leader>dt", dap_stop, opts)
keymap("n", "<F5>", ":DapContinue<CR>", opts)
keymap("n", "<F9>", ":DapToggleBreakpoint<CR>", opts)
keymap("n", "<F10>", ":DapStepOver<CR>", opts)
keymap("n", "<F11>", ":DapStepInto<CR>", opts)
keymap("n", "K", ':lua require("dapui").eval()<CR>', opts)

-- Session
vim.keymap.set("n", "<leader>zz", function()
    require("persistence").load()
    vim.cmd("NvimTreeOpen")
end, opts)

----------------------------------------------------------------------
-- AUTOCMDS
----------------------------------------------------------------------

vim.api.nvim_create_autocmd("BufRead", {
    pattern = {"*.vs", "*.vert", "*.fs", "*.frag"},
    callback = function() vim.bo.filetype = "glsl" end
})

vim.api.nvim_create_autocmd("BufRead", {
    pattern = {"*.hlsl"},
    callback = function() vim.bo.filetype = "hlsl" end
})

vim.api.nvim_create_autocmd("BufRead", {
    pattern = {"*.wgsl"},
    callback = function() vim.bo.filetype = "wgsl" end
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
        require("lint").try_lint()
    end
})

----------------------------------------------------------------------
-- COLORS
----------------------------------------------------------------------

vim.cmd("colorscheme vscode")
