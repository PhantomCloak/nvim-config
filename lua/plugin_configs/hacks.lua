-- Auto indention with insert mode
vim.cmd [[
hi Type guifg=#1e76ed
function! IndentWithI()
    if len(getline('.')) == 0
        return "\"_cc"
    else
        return "i"
    endif
endfunction
nnoremap <expr> i IndentWithI()
]]

-- Set something?
vim.api.nvim_set_hl(0, "TreesitterContext",{default = false, bg = "#363c4c"})


-- Disable virtual texts that came from LSP
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
   vim.lsp.diagnostic.on_publish_diagnostics,
   {
     virtual_text = false,
   })

