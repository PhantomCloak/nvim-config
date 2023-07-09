-- for signature helper
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
