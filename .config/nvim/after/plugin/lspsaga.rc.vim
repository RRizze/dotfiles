if !exists("g:loaded_lspsaga")
  finish
endif

lua << EOF
local keymap = vim.keymap.set
local saga = require("lspsaga")

saga.init_lsp_saga {
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  border_style = "round",
}

keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>",
  { silent = true, noremap = true })

EOF

" These mappings not work. Lua configs?
"nnoremap <silent> <C-j> <Cmd>Lspsaga diagnostic_jump_next<CR>
"nnoremap <silent>K <Cmd>Lspsaga hover_doc<CR>
"inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
"nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>

