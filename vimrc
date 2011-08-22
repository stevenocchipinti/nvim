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
" Auto indents after '{', etc., except if a comment char is placed afterwards
"set si
set wrap
set backspace=indent,eol,start
set incsearch
set ruler
"set columns=80
set wildmenu

set ignorecase
set smartcase

set linebreak
" Always show at least 5 lines at the top and the bottom
set scrolloff=5
" Show what mode your in (insert, etc.)
set warn

" Map <ctrl> + <up> and <ctrl> + <down> to scroll the page without moving the
" cursor, using <ctrl> + <e> and <ctrl> + <y> respectively.
map <C-Down> 
map <C-Up> 
imap <C-Down> a
imap <C-Up> a

" Map <F2> (in normal mode) to toggle highlighting for searches
nmap <F2> :set hls!:set hls?
"set hlsearch

set list
set listchars=tab:»·,trail:·
nmap <F3> :set list!:set list?

" Map =x to filter the file through xmllint to indent XML
map =x :%!xmllint -format -

" When you dont have write access, :W will write with sudo
command! W w !sudo tee % > /dev/null

" Make the mouse work - even in terminals
set mouse=a

" GUI dont was too big
set guifont=Monospace\ 9

" This automatically puts chars > 80 on the next line
"set textwidth=80

" This is for line numbers along the side:
"set nu

""" PLUGIN STUFF

" NerdTree
map <C-F> :NERDTreeToggle
imap <C-F> :NERDTreeToggle

" Gundo
nnoremap <F4> :GundoToggle<CR>

map <F5> 
imap <F5> a
