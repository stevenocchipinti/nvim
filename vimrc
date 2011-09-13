" Use Pathogen to keep plugins in bundles
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on


" Colors are good!
colorscheme herald
"set background=dark


" This is how to do stuff based on file extension
"autocmd BufEnter *.ace source $VIM/vim71/syntax/ace.vim


set ts=2 sw=2
set expandtab
set wrap
set backspace=indent,eol,start
set incsearch
set ruler
set wildmenu
set ignorecase
set smartcase
set linebreak
set warn              " Show what mode your in (insert, etc.)
set scrolloff=5       " Always show at least 5 lines at the top and the bottom
set mouse=a           " Make the mouse work - even in terminals
set autoindent        " Copy the indentation from the previous line
"set smartindent      " Auto indent after newlines, etc.
"set cursorline       " Highlights the line that haqs the cursor
"set textwidth=80     " This automatically puts chars > 80 on the next line
"set colorcolumn=81   " Highlight the 81st column (shorthand = :set cc=81)


" Shortcuts to configure folding
map <leader>fs :set foldmethod?
map <leader>fm :set foldmethod=manual
map <leader>fi :set foldmethod=indent
map <leader>fd :set foldmethod=diff
map <leader>f{ :set foldmethod=marker
map <leader>f} :set foldmethod=marker
map <leader>fc :set foldcolumn=1
map <leader>fC :set foldcolumn=4
map <leader>fn :set foldcolumn=0


" Map ctrl+up and ctrl+down to scroll the page without moving the cursor
map <C-Down> 
map <C-Up> 
imap <C-Down> a
imap <C-Up> a
map <C-j> 
map <C-k> 
imap <C-j> a
imap <C-k> a


" Map =x to filter the file through xmllint to indent XML
map =x :%!xmllint -format -

" NerdTree plugin
nmap <C-F> :NERDTreeToggle

" When you dont have write access, :W will write with sudo
command! W w !sudo tee % > /dev/null


" Function keys


"""""" F2
" Toggle highlighting for searches (in normal mode)
nmap <F2> :set hls!:set hls?
"set hlsearch


"""""" F3
" Toggle trailing whitespace and tab characters visibility
nmap <F3> :set list!:set list?
set list
set listchars=tab:=»,trail:·


"""""" F4
" Toggle line numbers along the side
nmap <F4> :set nu!:set nu?
set nu


"""""" F5
" Make switching windows easier
nmap <F5> w
imap <F5> wa
nmap <S-F5> W
imap <S-F5> Wa


"""""" F6
" Toggle Gundo plugin
nmap <F6> :GundoToggle<CR>


"""""" F7
" Toggle spellcheck
nmap <F7> :set spell!:set spell?


"""""" F8
" Toggle diff view (need to toggle on both desired buffers)
nmap <F8> :set diff! scb!:set diff?
