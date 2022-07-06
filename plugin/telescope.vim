lua << EOF
require("telescope").setup {
  defaults = {
    winblend = 5,
    selection_caret = " ",
    prompt_prefix = " ",
    mappings = {
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_better,
        ["<C-k>"] = require("telescope.actions").move_selection_worse,
      },
    },
  },
}
require("telescope").load_extension "coc"
EOF

nnoremap <leader>tt <cmd>Telescope<cr>
nnoremap <leader>tb <cmd>Telescope buffers<cr>
nnoremap <leader>th <cmd>Telescope help_tags<cr>
nnoremap <leader>te <cmd>Telescope file_browser<cr>
nnoremap <leader>tq <cmd>Telescope quickfix<cr>
nnoremap <leader>tr i<cmd>Telescope registers<cr>
" imap <C-r> <cmd>Telescope registers<cr>  " Buggy

" Files
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>tf <cmd>Telescope find_files<cr>

" Grep
nnoremap <leader>tg <cmd>Telescope live_grep<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>tG <cmd>Telescope grep_string<cr>
nnoremap <leader>G <cmd>Telescope grep_string<cr>

" Vim config
nnoremap <leader>. :lua require('telescope.builtin').find_files({
  \ search_dirs={"~/.config/nvim"}
  \ })<cr>

" COC in Telescope
nnoremap <leader>cm <cmd>Telescope coc mru<cr>
nnoremap <leader>cl <cmd>Telescope coc links<cr>
nnoremap <leader>cc <cmd>Telescope coc commands<cr>
nnoremap <leader>cr <cmd>Telescope coc references<cr>
nnoremap <leader>cd <cmd>Telescope coc definitions<cr>
nnoremap <leader>cD <cmd>Telescope coc declarations<cr>
nnoremap <leader>ci <cmd>Telescope coc implementations<cr>
nnoremap <leader>ct <cmd>Telescope coc type_definitions<cr>
nnoremap <leader>cg <cmd>Telescope coc diagnostics<cr>
nnoremap <leader>ca <cmd>Telescope coc code_actions<cr>
nnoremap <leader>cA <cmd>Telescope coc file_code_actions<cr>
nnoremap <leader>cs <cmd>Telescope coc document_symbols<cr>
nnoremap <leader>cS <cmd>Telescope coc workspace_symbols<cr>
nnoremap <leader>cG <cmd>Telescope coc workspace_diagnostics<cr>
