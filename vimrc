""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                              "
"                        __   _(_)_ __ ___  _ __ ___                           "
"                        \ \ / / | '_ ` _ \| '__/ __|                          "
"                         \ V /| | | | | | | | | (__                           "
"                          \_/ |_|_| |_| |_|_|  \___|                          "
"                                                                              "
"                                                                              "
"          http://stevenocchipinti.com                                         "
"          https://github.com/stevenocchipinti/dotvim                          "
"                                                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Use Pathogen to keep plugins in bundles
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           STANDARD VIM SETTINGS                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Colors are good!
syntax on
colorscheme herald
set t_Co=256
"set background=dark


" This will set filetype instead of sourcing a file
au! BufRead,BufNewFile *.haml setfiletype haml
au! BufRead,BufNewFile *.ino setfiletype cpp


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
set scrolloff=3       " Number of lines to always show at at the top and bottom
set mouse=a           " Make the mouse work - even in terminals
set autoindent        " Copy the indentation from the previous line
set colorcolumn=81    " Highlight the 81st column (shorthand = :set cc=81)
set cursorline        " Highlight the line which the cursor is on
set laststatus=2      " Always show a status bar
"set smartindent       " Auto indent after newlines, etc.
"set textwidth=80      " This automatically puts chars > 80 on the next line



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        CUSTOMIZED VIM FUNCTIONALITY                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Activate l33t mode!
"noremap <Up> <nop>
"noremap <Down> <nop>
"noremap <Left> <nop>
"noremap <Right> <nop>


" When you dont have write access, :W will write with sudo
" Without this, you could use ':w !sudo tee %'
command! W w !sudo tee % > /dev/null


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


" Map CTRL+<ARROW> to scroll the page without moving the cursor
map <C-Down> 
imap <C-Down> a
map <C-Up> 
imap <C-Up> a
map <C-Right> zL
imap <C-Right> zLa
map <C-Left> zH
imap <C-Left> zHa


" Easier way to copy and paste from the global clipboard
map <leader>p "+p
map <leader>y "+y
" Y should act like C and D!
map Y y$


" Shortcuts for ruby development and debugging
map <leader>d orequire 'ruby-debug'; debugger
map <leader>D Orequire 'ruby-debug'; debugger



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     CUSTOMIZED EXTERNAL FUNCTIONALITY                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Format JSON - filter the file through Python to format it
map =j :%!python -m json.tool


" Format Ruby Hash - convert to json and run the above python script
map =r :%s/=>/:/g:%!python -m json.tool


" Format XML - filter the file through xmllint to indent XML
map =x :%!xmllint -format -


" Run RSpec tests in Spin server
map <leader>t :w:!bundle exec spin push %
map <leader>T :w:call SpinLine()
function! SpinLine()
  exe "!bundle exec spin push ".expand('%').":".line('.')
endfunction



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  PLUGINS                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" TAG LIST PLUGIN - show tags (mnemonic: Ctags)
nmap <leader>c :TlistToggle
" Show the tags from just the focused file
let g:Tlist_Show_One_File=1
" Build ctags (requires exuberant-ctags)
nmap <leader>C :!ctags -R .


" NERDTREE PLUGIN - (mnemonic: Files)
nmap <leader>f :NERDTreeToggle
nmap <leader>F :NERDTreeFind


" NERDCOMMENTER PLUGIN - toggle line comment
map <Leader>/  <plug>NERDCommenterToggle<cr>


" GUNDO PLUGIN - show undo tree (mnemonic: Undo)
map <leader>u :GundoToggle


" POWERLINE PLUGIN
let g:Powerline_symbols='unicode'
let g:syntastic_mode_map = { 'mode': 'active' }


" CTRL-P PLUGIN
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git/', 'cd %s && git ls-files'],
    \ 2: ['.hg/', 'hg --cwd %s locate -I .'],
  \ },
  \ 'fallback': 'find %s -type f'
\ }


" FUZZY FINDER (mnemonic: Search-X)
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
" See :help fuf-vimrc-example for a full example



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               FUNCTION KEYS                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" F2 - Toggle highlighting for searches (in normal mode)
nmap <F2> :set hls!:set hls?
"set hlsearch


" F3 - Toggle trailing whitespace and tab characters visibility
set list
set listchars=tab:=»,trail:·
nmap <F3> :set list!:set list?


" F4 - Toggle line numbers along the side
nmap <F4> :set nu!:set nu?
set nu


" F5 - Make switching windows easier
nmap <F5> w
imap <F5> wa
nmap <S-F5> W
imap <S-F5> Wa


" F6 - Toggle line wrapping
nmap <F6> :set wrap!:set wrap?


" F7 - Toggle spellcheck
nmap <F7> :set spell!:set spell?


" F8 - Toggle diff view (need to toggle on both desired buffers)
nmap <F8> :set diff! scb!:set diff?
