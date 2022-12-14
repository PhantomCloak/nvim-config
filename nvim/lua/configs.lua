-- TREE SITTER CONFIG

treeSitterCfg = {
    ensure_installed = { "c", "lua", "rust" },
    sync_install = false,
    auto_install = true,
    ignore_install = { "javascript" },
    textobjects = {
        move = {
            enable = true,
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
}

-- TREE CONFIG
local fckLst = {
    { key = "R", action = "none" },
    { key = "f", action = "none" },
    { key = "a", action = "create" },
    { key = "F", action = "none" },
    { key = "FF", action = "none" },
    { key = "ff", action = "none" },
    { key = {"<CR>"}, action = "edit" },
}
treeCfg = {
    auto_reload_on_write = true,
    open_on_setup = false,
    open_on_setup_file = false,
    open_on_tab = true,
    prefer_startup_root = true,
    view = {
        centralize_selection = true,
        side = "left",
        width = 35,
        preserve_window_proportions = true,
        hide_root_folder = true,
        signcolumn = "no",
        mappings = {
         custom_only = true,
          list = fckLst,
        },
    },
    update_focused_file = {
        enable = true
    },
    renderer = {
        highlight_git = false,
        highlight_opened_files = "none",
        indent_width = 2,
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
        enable = false,
        ignore = true,
        show_on_dirs = true,
        timeout = 400,
    },
}

-- CONFIG LSP

local cmp = require('cmp')
local cmpnvimlsp = require('cmp_nvim_lsp')
vim.keymap.set('n', 'KF', vim.lsp.buf.hover, bufopts) -- it heps for var types

omnisharpLspCfg = {
    on_attach = function(client, bufnr)

        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts) -- it heps for var types

        lspformat.on_attach(client)
        keymap("n", "gd", ":lua require('omnisharp_extended').lsp_definitions()<CR>", opts)

        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.softtabstop = 4

    end,
    handlers = {
        --["textDocument/definition"] = require("omnisharp_extended").handler,
    },
    cmd = { "/Users/unalozyurt/Downloads/omnisharp-osx-arm64-net6.0/OmniSharp", "--languageserver", "--hostPID",
        tostring(pid) },
}

clangdLspCfg = {
    on_attach = function(client, bufnr)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        require'lsp_signature'.on_attach()
        
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.softtabstop = 2
    end
}

-- CONFIG CMP

local MAX_LABEL_WIDTH = 20
local ELLIPSIS_CHAR = '???'
cmpConfig = {
    appearance = {
        menu = {
            direction = 'below' -- auto or above or below
        }
    },
    formatting = {
        format = require('lspkind').cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
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
}

-- CONFIG LSP SIGNATURE

lspSignatureCfg = {
    log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log",
    bind = true,
    doc_lines = 2,
    floating_window_above_cur_line = false,
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
            "%.asset", "%.unity", "%.ttf", "%.png", "%.jpg", "%.prefab", "%.ogg",
            "%.anim", "%.fbx", "%.obj", "%.tga", "%.shader", "%.swcode", "%.mat",
            "%.vfx", "%.FBX", "%.asmdef", "%.controller", "%.dll", "%.TGA",
            "%.file" },
    }
}

-- CONFIG LUALINE

lualineCfg = {
    options = {
        theme = 'codedark',
        globalstatus = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { '', '', '' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
}

-- CONFIG TROUBLE

troubleCfg = {
    mode = "document_diagnostics",
    auto_fold = false,
    padding = false,
    auto_open = false,
    auto_close = false,
    auto_jump = {},
    use_diagnostic_signs = false,
    icons = true,
    auto_preview = true,
}

-- CONFIG NEOTEST

neoTestCfg = {
    adapters = {
        require("neotest-dotnet"),
        require("neotest-plenary"),
    },
}
-- CONFIG DAP

local dap = require('dap')

dap.adapters.unity = {
    type = 'executable',
    command = '/Library/Frameworks/Mono.framework/Versions/Current/Commands/mono',
    args = { '/Users/unalozyurt/.vscode/extensions/unity.unity-debug-3.0.2/bin/UnityDebug.exe' }
}

dap.configurations.cs = {
    {
        type = 'unity',
        request = 'attach',
        name = 'Unity Editor',
        program = function()
            return
        end,
    }
}

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

dapCodeLLDBCfg = {
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

dap.adapters.codelldb = dapCodeLLDBCfg
dap.configurations.c = dapCCfg
dap.repl.commands = vim.tbl_extend('force', dap.repl.commands, dapReplCfg)

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.cpp

-- CONFIG DAPUI

dapUiCfg = {
    expand_lines = true,
      mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "K",
    toggle = "t",
    },
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 50, -- 40 columns
            position = "left",
        },
        {
            elements = {
                { id = "console", size = 0.50},
                { id = "scopes", size = 0.50},
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
    }
}

bufferLineCfg = {
    options = {
        mode = "tabs", -- set to "tabs" to only show tabpages instead
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
            }
        },
    },
    highlights = {
        separator_selected = {
            fg = "#252526",
            bg = "#1e1e1e"
        },
    },
}

require("bufferline").setup(bufferLineCfg)

fzfLspFuzzyCfg = {
    methods = 'all', -- either 'all' or a list of LSP methods (see below)
    jump_one = true, -- jump immediately if there is only one location
    save_last = true, -- save last location results for the :LspFuzzyLast command
    fzf_preview = { -- arguments to the FZF '--preview-window' option
        'right:+{2}-/2:noborder'
    },
    fzf_modifier = ':~:', -- format FZF entries, see |filename-modifiers|
}

vim.cmd([[ 
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal' } }
]])


require"nvim-tree.view".View.winopts.cursorline = true
-- FZF
vim.cmd([[
colorscheme darkplus

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
let $FZF_DEFAULT_COMMAND = 'rg -F -g "*.cs" -g "*.c" -g "*.cpp" -g "*.h" --files --hidden'
let $FZF_DEFAULT_OPTS = '--bind tab:down,shift-tab:up'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=never --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

  function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg -g "*.yml" -g "*.cs" -g "*.cpp" -g "*.h" -g "*.js" --column --line-number --no-heading --color=always --smart-case %s | sed "s/ \{1,\}/ /g" || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command, '--with-nth=..4']}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
]])

vim.cmd([[
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
]])
--vim.diagnostic.disable()