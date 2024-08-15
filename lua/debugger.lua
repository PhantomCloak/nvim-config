-- ===========================
-- Debugger for C# & C++
-- ===========================

local dap = require('dap')
local dapui = require('dapui')

dap.adapters.unity = {
    type = 'executable',
    command = getMonoPath(), -- should get from lsp.lua
    args = { os.getenv('HOME') .. '/.UnityDbg/bin/UnityDebug.exe' }
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

dapReplCfg = {
    exit = { 'q', 'exit' },
    custom_commands = {
        ['.run_to_cursor'] = dap.run_to_cursor,
        ['.restart'] = dap.run_last
    }
}

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

dap.repl.commands = vim.tbl_extend('force', dap.repl.commands, dapReplCfg)

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.cpp

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

dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {os.getenv("HOME") .. "/nvim-debug-servers/vscode-chrome-debug/out/src/chromeDebug.js"}
}

dap.configurations.javascriptreact = { -- change this to javascript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}

dap.configurations.typescript = { -- change to typescript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}

dapui.setup(dapUiCfg);

local ok, godot = pcall(require, "godot")
if not ok then
	return
end
local config = {
    bin = "/Users/ph4nt0m/Downloads/Godot_mono.app/Contents/MacOS/Godot",
-- 	gui = {
-- 		console_config = @config for vim.api.nvim_open_win
-- 	},
}

godot.setup(config)

local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end
