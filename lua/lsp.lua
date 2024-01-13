-- ===========================
-- Autocomplete for C# & C++
-- ===========================

opts = { noremap = true, silent = true }
api = vim.api
keymap = vim.api.nvim_set_keymap

-- Defs

local lspconfig = require("lspconfig")
local lspsignature = require("lsp_signature")
local lspkind = require("lspkind")
local cmp = require('cmp')
--local lspformat = require("lsp-format")
local autopairs = require("nvim-autopairs")

-- JS
require("typescript-tools").setup {
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = "insert_leave",
    -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
    -- "remove_unused_imports"|"organize_imports") -- or string "all"
    -- to include all supported code actions
    -- specify commands exposed as code_actions
    expose_as_code_action = {},
    -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
    -- not exists then standard path resolution strategy is applied
    tsserver_path = nil,
    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    -- (see 💅 `styled-components` support section)
    tsserver_plugins = {},
    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    -- memory limit in megabytes or "auto"(basically no limit)
    tsserver_max_memory = "auto",
    -- described below
    tsserver_format_options = {},
    tsserver_file_preferences = {},
    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
    complete_function_calls = false,
    include_completions_with_insert_text = true,
  },
}

-- C#

function getMonoPath()
    local f = assert(io.popen('which mono', 'r')) local s = assert(f:read('*a'))
    f:close()
    s = s:gsub('^%s*(.-)%s*$', '%1') -- trim
    if s == '' then
        return nil
    end
    return s
end

omnisharpLspCfg = {
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
}

-- Autocompletion Config

cmpConfig = {
    appearance = {
        menu = {
            direction = 'below'
        }
    },
    formatting = {
        format = lspkind.cmp_format({
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
}

-- CONFIG LSP SIGNATURE

lspSignatureCfg = {
    log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log",
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
}

cmp.setup(cmpConfig)

lspconfig.omnisharp.setup(omnisharpLspCfg)
lspconfig.clangd.setup({ cmd = { "clangd", "--offset-encoding=utf-16", }, } )
lspconfig.pyright.setup{}
lspconfig.gopls.setup{}
lspconfig.tsserver.setup {}

lspsignature.setup(lspSignatureCfg)

--lspformat.setup()
autopairs.setup()

require('lspsaga').setup({
        lightbulb = {
                virtual_text = false,
        }
})
