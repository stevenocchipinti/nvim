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


" Use Vundle to manage plugins
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'bling/vim-airline'
Bundle 'bogado/file-line'
Bundle 'stevenocchipinti/runnermux'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'godlygeek/tabular'
Bundle 'mattn/emmet-vim'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-rake'
Bundle 'vim-scripts/matchit.zip'
Bundle 'vim-scripts/grep.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tangledhelix/vim-octopress'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'groenewege/vim-less'
Bundle 'vim-ruby/vim-ruby'
Bundle 'editorconfig/editorconfig-vim'
" Bundle 'flazz/vim-colorschemes'
call yankstack#setup()
filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           STANDARD VIM SETTINGS                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Colors are good!
syntax on
colorscheme herald
set t_Co=256
"set background=dark

" Improve vim's scrolling speed
set ttyfast
set ttyscroll=3
set lazyredraw

" This will set filetype instead of sourcing a file
au! BufRead,BufNewFile *.haml setfiletype haml
au! BufRead,BufNewFile *.ino setfiletype cpp
autocmd BufNewFile,BufRead *.markdown,*.textile set filetype=octopress
autocmd BufNewFile,BufRead *.hbs,*.handlebars set filetype=html


set ts=2 sw=2           " Use 2 spaces for tabs
set expandtab           " Use spaces instead of tab characters
set wrap                " Wrap the display lines (not actual text)
set linebreak
set splitright          " Open vertical splits on the right
set splitbelow          " Open the horizontal split below
set backspace=indent,eol,start
set incsearch           " Show matching search results as typing
set ruler               " Show row and column in status bar
set wildmenu            " Nicer tab completion for :ex commands
set ignorecase          " Case insensitive search by default
set smartcase           " Use case sensitive search in a captial letter is used
set warn                " Show what mode your in (insert, etc.)
set scrolloff=3         " Number of lines to always show at at the top & bottom
set autoindent          " Copy the indentation from the previous line
set colorcolumn=81,120  " Highlight the 81st column (shorthand = :set cc=81)
set cursorline          " Highlight the line which the cursor is on
set laststatus=2        " Always show a status bar
set mouse=a             " Make the mouse work - even in terminals
set list                " Show `listchars` characters
set nojoinspaces        " Use 1 space after "." when joining lines instead of 2
set shiftround          " Indent to the closest shiftwidth
set exrc                " Allow a .vimrc in the project directory
set secure              " Make sure those project .vimrc's are safe
set listchars=tab:=»,trail:·

" Make vim remember undos, even when the file is closed!
set undofile                    " Save undo's after file closes
set undodir=~/.vim/undo         " where to save undo histories
set undolevels=1000             " How many undos
set undoreload=10000            " number of lines to save for undo


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        CUSTOMIZED VIM FUNCTIONALITY                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



" Quicker escaping
" imap kj 


" When you dont have write access, :W will write with sudo
" Without this, you could use ':w !sudo tee %'
command! W w !sudo tee % > /dev/null


" :Q is an accidental error for :q
cnoreabbrev Q q


" Easier way to copy and paste from the global clipboard
map <leader>p "+p
map <leader>y "+y
" Y should act like C and D!
map Y y$


" Shortcuts for debugging
autocmd FileType ruby map <leader>d orequire 'pry'; binding.pry; puts ""
autocmd FileType ruby map <leader>D Orequire 'pry'; binding.pry; puts ""
autocmd FileType ruby map <leader>s osave_screenshot("/tmp/screenshot.png", full: true)
autocmd FileType ruby map <leader>S Osave_screenshot("/tmp/screenshot.png", full: true)

autocmd FileType javascript map <leader>d odebugger;
autocmd FileType javascript map <leader>D Odebugger;

au BufEnter *.rb syn match error contained "\<binding.pry\>"
au BufEnter *.rb,*.js syn match error contained "\<debugger\>"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     CUSTOMIZED EXTERNAL FUNCTIONALITY                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Format JSON - filter the file through Python to format it
map =j :%!python -m json.tool


" Format Ruby Hash - convert to json and run the above python script
map =r :%s/=>/:/g:%!python -m json.tool


" Format XML - filter the file through xmllint to indent XML
map =x :%!xmllint -format -


" Remove un-needed whitespace
map <silent> =w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  PLUGINS                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" YANKSTACK PLUGIN
nmap <leader>o <Plug>yankstack_substitute_older_paste
nmap <leader>i <Plug>yankstack_substitute_newer_paste


" GREP PLUGIN
map <leader>g :Rgrep
map <leader>G :Grep


" TAG LIST PLUGIN - show tags (mnemonic: Ctags)
" Show the tags from just the focused file
let g:Tlist_Show_One_File=1
nmap <leader>c :TlistToggle
" Build ctags (requires exuberant-ctags)
nmap <leader>C :!ctags -R .


" NERDTREE PLUGIN - (mnemonic: Files)
nmap <leader>f :NERDTreeToggle
nmap <leader>F :NERDTreeFind


" GUNDO PLUGIN - show undo tree (mnemonic: Undo)
map <leader>u :GundoToggle


" AIRLINE PLUGIN
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0


" SYNTASTIC PLUGIN
let g:syntastic_javascript_checkers = ['eslint']


" CTRL-P PLUGIN
let g:ctrlp_user_command = {
\   'types': {
\     1: ['.git/', 'cd %s && git ls-files -co --exclude-standard'],
\     2: ['.hg/', 'hg --cwd %s locate -I .'],
\   },
\   'fallback': 'find %s -type f'
\ }
map <leader><C-P> <C-P><C-\>w


" EMMET PLUGIN
" I use <C-y> (default) much more often than <C-f>
let g:user_emmet_leader_key='<C-f>'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               FUNCTION KEYS                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" F2 - Toggle highlighting for searches (in normal mode)
nmap <F2> :set hls!:set hls?
"set hlsearch


" F3 - Toggle trailing whitespace and tab characters visibility
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
