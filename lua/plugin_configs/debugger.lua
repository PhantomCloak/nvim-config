local dap = require('dap')

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