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

vim.keymap.set('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
vim.keymap.set('n', '<C-x>', ':belowright sp<CR>:lua vim.lsp.buf.definition()<CR>', opts)

vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
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


		  --vim.keymap.set('n', '<C-v>', ':vsp<CR>:lua vim.lsp.buf.definition()<CR>', opts)
		  --vim.keymap.set('n', '<C-x>', ':sp<CR>:lua vim.lsp.buf.definition()<CR>', opts)

          keymap("n", "m", ":ClangdSwitchSourceHeader<CR>", opts)
        elseif client.name == 'tsserver' then
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        end
      end
  end,
})
-- DAP

function show_git_diff()
    vim.cmd("NvimTreeClose")
    vim.cmd('Gitsign diffthis')  
end

keymap("n", "fs", ":Ag ", opts)
keymap("n", "ff", ":FZF<CR>", opts)

-- LSP Telescopj
