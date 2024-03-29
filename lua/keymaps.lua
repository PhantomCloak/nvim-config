opts = { noremap = true, silent = true }
api = vim.api
keymap = vim.api.nvim_set_keymap

-- Control

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "rr", ":q<CR>", opts)

keymap("n", "<C-n>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<C-m>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "tt", ":below split | resize 20 | term<CR>", opts)
keymap("n", "<C-c>", ":bdelete<CR>", opts)

keymap("n", "vp", ":BufferPick<CR>", opts)
keymap("n", "vv", ":RG<CR>", opts)

-- Git

keymap("n", "<leader>lg", ":LazyGit<CR>", opts)

keymap("n", "<leader>gb", ":Git blame<CR>", opts)
keymap("n", "<leader>ggb", ":GBrowse<CR>", opts)
keymap("n", "<leader>gv", ":GV?<CR>", opts)
keymap("n", "<leader>gs", ":<cmd>lua show_git_diff()<CR>", opts)
keymap("n", "<leader>gp", ":Gitsign previw_hunk<CR>", opts)
keymap("n", "<leader>gr", ":Gitsign undo_stage_hunk<CR>", opts)

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
      keymap("n", "<leader>co",":lua vim.lsp.buf.code_action()<CR>", opts)
      keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
      keymap("n", "rn", ":lua vim.lsp.buf.rename()<CR>", opts)

      local clients = vim.lsp.buf_get_clients(0)
      for _, client in pairs(clients) do
        if client.name == 'omnisharp' then
          vim.keymap.set('n', 'gd', ":lua require('omnisharp_extended').lsp_definitions()<CR>", opts)
          vim.keymap.set('n', 'gj', ":lua require('csharpls_extended').lsp_definitions()<CR>", opts)

          vim.opt.softtabstop = 4
          vim.opt.tabstop = 4
          vim.opt.shiftwidth = 4
        elseif client.name == 'clangd' then

          vim.opt.softtabstop = 2
          vim.opt.tabstop = 2
          vim.opt.shiftwidth = 2

          vim.keymap.set('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
          keymap("n", "m", ":ClangdSwitchSourceHeader<CR>", opts)
        elseif client.name == 'tsserver' then
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        end
      end
  end,
})
-- DAP

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

function show_git_diff()
    vim.cmd("NvimTreeClose")
    vim.cmd('Gitsign diffthis')  
end
-- FZF

keymap("n", "fs", ":Ag ", opts)
-- Telescope

keymap("n", "<leader>fc", ":Telescope command_center<CR>", opts)
keymap("n", "<leader>dD", ":Telescope lsp_document_diagnostics<CR>", opts)
keymap("n", "<leader>dW", ":Telescope lsp_workspace_diagnostics<CR>", opts)
keymap("n", "<leader>ca", ":%Telescope lsp_range_code_actions", opts)
keymap("n", "tc", ":lua require'telescope.builtin'.commands(require('telescope.themes').get_dropdown({}))<CR>", opts)
keymap("n", "<F3>", ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<CR>", opts)
keymap("n", "rt", ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<CR>", opts)
keymap("n", "ff", ":FZF<CR>", opts)
keymap("n", "tn", ":tabedit blank | FZF<CR>", opts)

-- LSP Telescopj
