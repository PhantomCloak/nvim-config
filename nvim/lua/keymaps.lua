
-- Control

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "rr", ":q<CR>", opts)

-- Git

keymap("n", "<leader>lg", ":LazyGit<CR>", opts)
keymap("n", "<leader>gb", ":Git blame<CR>", opts)
keymap("n", "<leader>ggb", ":GBrowse<CR>", opts)
keymap("n", "<leader>gv", ":GV?<CR>", opts)
keymap("n", "<leader>gs", ":Gdiffsplit!<CR>", opts)

-- LSP

keymap("n", "rn", ":lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "gr", ":Telescope lsp_references<CR>", opts)

keymap("n", "<leader>co",":lua vim.lsp.buf.code_action()<CR>", opts)

-- Telescope

keymap("n", "<leader>fc", ":Telescope command_center<CR>", opts)
keymap("n", "<leader>dD", ":Telescope lsp_document_diagnostics<CR>", opts)
keymap("n", "<leader>dW", ":Telescope lsp_workspace_diagnostics<CR>", opts)
keymap("n", "<leader>ca", ":%Telescope lsp_range_code_actions", opts)
keymap("n", "tc", ":lua require'telescope.builtin'.commands(require('telescope.themes').get_dropdown({}))<CR>", opts)
keymap("n", "<F3>", ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<CR>", opts)
keymap("n", "<F4>", ":Telescope live_grep<CR>", opts)
keymap("n", "ff", ":lua require'telescope.builtin'.live_grep({grep_open_files=true})<CR>", opts)
keymap("n", "tn", ":tabedit "..  vim.fn.getcwd() .."| Telescope find_files<CR>", opts)

-- LSP Telescope

keymap("n", "gr", ":Telescope lsp_references", opts)
keymap("n", "gd",":lua require('omnisharp_extended').telescope_lsp_definitions()<CR>", opts)
--keymap("n", "gd",":Telescope lsp_definition<CR>", opts)
