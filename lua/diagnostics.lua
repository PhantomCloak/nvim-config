-- ===========================
-- LSP Diagnostic Message Window
-- ===========================

troubleCfg = {
    mode = "document_diagnostics",
    auto_fold = false,
    padding = false,
    auto_open = false,
    auto_close = false,
    auto_jump = {},
    use_diagnostic_signs = false,
    icons = true,
    auto_preview = true,
}

local trouble = require("trouble")
trouble.setup(troubleCfg)

