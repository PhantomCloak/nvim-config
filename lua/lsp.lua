-- ===========================
-- Autocomplete for C# & C++
-- ===========================

-- Defs

local lspconfig = require("lspconfig")
local lspsignature = require("lsp_signature")
local lspkind = require("lspkind")
local cmp = require('cmp')
local lspformat = require("lsp-format")
local autopairs = require("nvim-autopairs")

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
    on_attach = function(client, bufnr)

        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts) -- it heps for var types

        lspformat.on_attach(client)
        keymap("n", "gd", ":lua require('omnisharp_extended').lsp_definitions()<CR>", opts)
        keymap("n", "gj", ":lua require('csharpls_extended').lsp_definitions()<CR>", opts)

        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.softtabstop = 4

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

-- C+++

clangdLspCfg = {
    on_attach = function(client, bufnr)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        lspsignature.on_attach()
        
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.softtabstop = 2
    end
}



-- Autocompletion Config

cmpConfig = {
    appearance = {
        menu = {
            direction = 'below' -- auto or above or below
        }
    },
    formatting = {
        format = lspkind.cmp_format({
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
lspconfig.clangd.setup(clangdLspCfg)
lspsignature.setup(lspSignatureCfg)

lspformat.setup()
autopairs.setup()
