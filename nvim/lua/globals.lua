keymap = vim.api.nvim_set_keymap
opts = { noremap = true, silent = true }
api = vim.api

ayu = require("ayu")

nvimtreesitter = require('nvim-treesitter.configs')
bufferline = require("bufferline")

bqf = require("bqf")
qf = require("qf")
dressing = require("dressing")

lspkind = require("lspkind")
lspconfig = require("lspconfig")
cmpnvimlsp = require('cmp_nvim_lsp')

dap = require('dap')
dapui = require('dapui')

lspformat = require("lsp-format")
lspsignature = require("lsp_signature")
lspcolors = require("lsp-colors")
lspfuzzy = require('lspfuzzy')
neoterm = require('neoterm')

navic = require("nvim-navic")
lualine = require("lualine")
trouble = require("trouble")

omnisharpexnteded = require("omnisharp_extended")
autopairs = require("nvim-autopairs")
mason = require("mason")
