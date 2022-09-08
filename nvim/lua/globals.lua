 keymap = vim.api.nvim_set_keymap
 opts = { noremap = true, silent = true } 
 api = vim.api

 ayu = require("ayu")

 nvimtree = require("nvim-tree")
 nvimtreesitter = require('nvim-treesitter.configs')
 bufferline = require("bufferline")

 bqf = require("bqf")
 qf = require("qf")
 dressing = require("dressing")

 lspkind = require("lspkind")
 lspconfig = require("lspconfig")
 cmp = require("cmp")
 cmpnvimlsp = require('cmp_nvim_lsp')

dap = require('dap')
dapui = require('dapui')

 lspformat = require("lsp-format")
 lspsignature = require("lsp_signature")
 lspcolors = require("lsp-colors")

 navic = require("nvim-navic")
 telescope = require("telescope")
 lualine = require("lualine")
 trouble = require("trouble")

 omnisharpexnteded = require("omnisharp_extended")
 autopairs = require("nvim-autopairs")
 mason = require("mason")
