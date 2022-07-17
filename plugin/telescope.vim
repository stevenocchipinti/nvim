lua << EOF
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

require("telescope").setup {
  defaults = {
    winblend = 5,
    selection_caret = " ",
    prompt_prefix = " ",
    mappings = {
      i = {
        ["<C-j>"] = require("telescope.actions").move_selection_better,
        ["<C-k>"] = require("telescope.actions").move_selection_worse,
        ["<c-t>"] = trouble.open_with_trouble
      },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}
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

