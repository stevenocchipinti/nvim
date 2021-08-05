" Highlight what was just yanked
au TextYankPost * silent! lua vim.highlight.on_yank


" Sudo write
cmap w!! w !sudo tee %


" Shortcut for spellcheck
nnoremap <leader>z :set spell<cr>:Telescope spell_suggest<cr>
nnoremap <leader>Z :set nospell<cr>


" :Q is an accidental error for :q
cnoreabbrev Q q
" Q is another common accidental error to launch :ex mode - which I don't use
nnoremap Q <nop>


" Easier way to copy and paste from the system clipboard
noremap <leader>p "+p
noremap <leader>y "+y
" Y should act like C and D!
nnoremap Y y$


" Better use of slash:
"   Single slash = Search WITHOUT highlighting (for jumping around)
"   Double slash = Search WITH highlighting (for viewing results)
"
" ProTip, this also allows:
"   //<ESC> = turn on highlighting
"   /<ESC>  = turn off highlighting
nnoremap // :set hls<CR>/
nnoremap / :set nohls<CR>/

" Keep the cursor still and highlight matches when pressing *
nnoremap <silent><expr> * v:count
\ ? '*'
\ : ':set hls <Bar> execute "keepjumps normal! *" <Bar> call winrestview(' . string(winsaveview()) . ')<CR>'


" Better Markdown file defaults
autocmd BufNewFile,BufRead *.markdown,*.textile setlocal filetype=octopress
autocmd FileType octopress,markdown nnoremap <leader>= yyp:s/./=/g<cr>
autocmd FileType octopress,markdown nnoremap <leader>- yyp:s/./-/g<cr>
autocmd FileType octopress,markdown,gitcommit setlocal spell
autocmd FileType octopress,markdown,gitcommit setlocal textwidth=80


" Set a nicer foldtext function
set foldtext=MinimalFoldText()
function! MinimalFoldText()
  let line = getline(v:foldstart)
  let n = v:foldend - v:foldstart + 1
  set fillchars=fold:\ 
  return line . " ⏎ " . n
endfunction


" Format JSON - filter the file through Python to format it
nnoremap =j :%!python -m json.tool<cr>
vnoremap =j :'<,'>!python -m json.tool<cr>


" Format XML - filter the file through xmllint to format it
nnoremap =x :%!xmllint -format -<cr>
vnoremap =x :'<,'>!xmllint -format -<cr>


" Format Lua - filter the file through stylua to format it
nnoremap =l :%!stylua -<cr>
vnoremap =l :'<,'>!stylua -<cr>


" Remove un-needed whitespace
nnoremap <silent> =w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
