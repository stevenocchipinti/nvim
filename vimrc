" Use Pathogen to keep plugins in bundles
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on


" Color!
colorscheme herald
"set background=dark


" This is how to do stuff based on file extension
"autocmd BufEnter *.ace source $VIM/vim71/syntax/ace.vim


set autoindent
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
"set columns=80


" Always show at least 5 lines at the top and the bottom
set scrolloff=5
" Show what mode your in (insert, etc.)
set warn
" Make the mouse work - even in terminals
set mouse=a
" GUI font was too big
set guifont=Monospace\ 9
" This automatically puts chars > 80 on the next line
"set textwidth=80
" Auto indents after '{', etc., except if a comment char is placed afterwards
"set si


" Map <ctrl> + <up> and <ctrl> + <down> to scroll the page without moving the
" cursor, using <ctrl> + <e> and <ctrl> + <y> respectively.
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

" When you dont have write access, :W will write with sudo
command! W w !sudo tee % > /dev/null


" Map <F2> (in normal mode) to toggle highlighting for searches
"set hlsearch
nmap <F2> :set hls!:set hls?

" This makes trailing whitespace and tab characters visible
set list
set listchars=tab:»·,trail:·
nmap <F3> :set list!:set list?

" This is for line numbers along the side:
set nu
nmap <F4> :set nu!:set nu?

" Make switching windows easier
nmap <F5> w
imap <F5> wa
nmap <S-F5> W
imap <S-F5> Wa


""" PLUGIN STUFF

" NerdTree
nmap <C-F> :NERDTreeToggle

" Gundo
nmap <F6> :GundoToggle<CR>
