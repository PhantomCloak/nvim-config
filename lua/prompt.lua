-- ===========================
-- Find File & Find Text Prompt
-- LSP Prompts
-- ===========================

fzfLspFuzzyCfg = {
    methods = 'all', -- either 'all' or a list of LSP methods (see below)
    jump_one = true, -- jump immediately if there is only one location
    save_last = true, -- save last location results for the :LspFuzzyLast command
    fzf_preview = { -- arguments to the FZF '--preview-window' option
        'right:+{2}-/2:noborder'
    },
    fzf_modifier = ':~:', -- format FZF entries, see |filename-modifiers|
}

local lspfuzzy = require('lspfuzzy')
lspfuzzy.setup(fzfLspFuzzyCfg)

vim.cmd([[
colorscheme vscode
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal' } }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_preview_window = ['right:50%:noborder']

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline --height 40% --preview-window noborder'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"
let $FZF_DEFAULT_COMMAND = 'rg -F --files --hidden'
let $FZF_DEFAULT_OPTS = '--bind tab:down,shift-tab:up'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=never --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

  function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg -g "*" --column --line-number --no-heading --color=always --smart-case %s | sed "s/ \{1,\}/ /g" || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command, '--with-nth=..4']}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
]])


