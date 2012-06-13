" Use Pathogen to keep plugins in bundles
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on


" Colors are good!
syntax on
colorscheme herald
"set background=dark


" This is how to source a file based on file extension
"autocmd BufEnter *.ace source $VIM/vim71/syntax/ace.vim

" This will set filetype instead of sourcing a file
au! BufRead,BufNewFile *.haml setfiletype haml


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
set colorcolumn=81    " Highlight the 81st column (shorthand = :set cc=81)
set laststatus=2      " Always show a status bar
"set smartindent       " Auto indent after newlines, etc.
"set cursorline        " Highlights the line that has the cursor
"set textwidth=80      " This automatically puts chars > 80 on the next line


" Make Powerline look nicer
let g:Powerline_symbols='unicode'
let g:syntastic_mode_map = { 'mode': 'active' }
set t_Co=256


" Activate l33t mode!
"map <Down> ""
"imap <Down> 
"map <Up> ""
"imap <Up> 
"map <Right> ""
"imap <Right> 
"map <Left> ""
"imap <Left> 


" Shortcuts for development
map <leader>d orequire 'ruby-debug'; debugger
map <leader>D Orequire 'ruby-debug'; debugger

" Run RSpec tests in Spin server
map <leader>t :!bundle exec spin push %
" Spin doesn't seem to support line numbers :(
map <leader>T :call SpinLine()
function SpinLine()
  let num = line('.')
  exe "!bundle exec spin push ".expand('%').":".num
endfunction


" Shortcuts to configure folding
map <leader>zs :set foldmethod?
map <leader>zm :set foldmethod=manual
map <leader>zi :set foldmethod=indent
map <leader>zd :set foldmethod=diff
map <leader>z{ :set foldmethod=marker
map <leader>z} :set foldmethod=marker
map <leader>zc :set foldcolumn=1
map <leader>zC :set foldcolumn=4
map <leader>zn :set foldcolumn=0


" Shortcuts for searching with FuzzyFinder
" See :help fuf-vimrc-example for a full example
map <leader>sb :FufBuffer
map <leader>sf :FufFile
map <leader>sF :FufFileWithCurrentBufferDir
map <leader>sd :FufDir
map <leader>sD :FufDirWithCurrentBuffer
map <leader>st :FufTag
map <leader>s] :FufTagWithCursorWord
map <leader>sj :FufJumpList
map <leader>sc :FufChangeList
map <leader>sq :FufQuickfix
map <leader>sl :FufLine
map <leader>sh :FufHelp


" Map CTRL+<ARROW> to scroll the page without moving the cursor
map <C-Down> 
imap <C-Down> a
map <C-Up> 
imap <C-Up> a
map <C-Right> zL
imap <C-Right> zLa
map <C-Left> zH
imap <C-Left> zHa


" Show ctags - TagList plugin
nmap <leader>c :TlistToggle
" Build ctags (requires exuberant-ctags)
nmap <leader>C :!ctags -R .

" Show files - NerdTree plugin
nmap <leader>f :NERDTreeToggle
" Toggle Gundo plugin
map <leader>u :GundoToggle


" Easier way to copy and paste from the global clipboard
map <leader>p "+p
map <leader>y "+y
" Y should act like C and D!
map Y y$


" Map =j to filter the file through Python to format it
map =j :%!python -m json.tool
" Map =x to filter the file through xmllint to indent XML
map =x :%!xmllint -format -

" When you dont have write access, :W will write with sudo
" Without this, you could use ':w !sudo tee %'
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
nmap <F6> :set wrap!:set wrap?


"""""" F7
" Toggle spellcheck
nmap <F7> :set spell!:set spell?


"""""" F8
" Toggle diff view (need to toggle on both desired buffers)
nmap <F8> :set diff! scb!:set diff?
