""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                              "
"      _ __   ___  _____   _(_)_ __ ___       ___ ___  _ __  / _(_) __ _       "
"     | '_ \ / _ \/ _ \ \ / / | '_ ` _ \     / __/ _ \| '_ \| |_| |/ _` |      "
"     | | | |  __/ (_) \ V /| | | | | | |   | (_| (_) | | | |  _| | (_| |      "
"     |_| |_|\___|\___/ \_/ |_|_| |_| |_|    \___\___/|_| |_|_| |_|\__, |      "
"                                                                  |___/       "
"                                                                              "
"          http://stevenocchipinti.com                                         "
"          https://github.com/stevenocchipinti/dotvim                          "
"                                                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


call plug#begin('~/.config/nvim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neomake/neomake'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/matchit.zip'
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'mattn/emmet-vim'
Plug 'bogado/file-line'
Plug 'bfredl/nvim-miniyank'

" Technology specific plugins
Plug 'vim-ruby/vim-ruby'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-markdown'
Plug 'tangledhelix/vim-octopress'
Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
Plug 'moll/vim-node'
Plug 'mxw/vim-jsx'
call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           STANDARD VIM SETTINGS                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set ts=2 sw=2           " Use 2 spaces for tabs
set expandtab           " Use spaces instead of tab characters
set nowrap              " (Dont) Wrap the display lines (not actual text)
set nu                  " Show line numbers
set splitright          " Open vertical splits on the right
set splitbelow          " Open the horizontal split below
set ruler               " Show row and column in status bar
set ignorecase          " Case insensitive search by default
set smartcase           " Use case sensitive search in a capital letter is used
set nohlsearch          " Don't highlight searches, useful for jumping around
set scrolloff=3         " Number of lines to always show at at the top & bottom
set colorcolumn=81,91   " Highlight the 81st column (shorthand = :set cc=81)
set cursorline          " Highlight the line which the cursor is on
set nojoinspaces        " Use 1 space after "." when joining lines instead of 2
set shiftround          " Indent to the closest shiftwidth
set secure              " Make sure those project .vimrc's are safe
set list                " Show `listchars` characters
set listchars=tab:├─,trail:·

" Make vim remember undos, even when the file is closed!
set undofile            " Save undo's after file closes
set undodir=~/.vim/undo " where to save undo histories
set undolevels=1000     " How many undos
set undoreload=10000    " number of lines to save for undo

" COLOR!
colorscheme tomorrow-night


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          NEOVIM SPECIFIC SETTINGS                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("nvim")
  set inccommand=nosplit  " Live search and replace
  map <C-l> :mode  " Workaround https://github.com/neovim/neovim/issues/3929
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          CUSTOM VIM FUNCTIONALITY                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" When you dont have write access, :W will write with sudo
" Without this, you could use ':w !sudo tee %'
command! W w !sudo tee % > /dev/null


" Shortcut for spellcheck
map <leader>z :set spellz=
map <leader>Z :set nospell


" :Q is an accidental error for :q
cnoreabbrev Q q


" Easier way to copy and paste from the global clipboard
map <leader>p "+p
map <leader>y "+y
" Y should act like C and D!
map Y y$


" Shortcuts for debugging
autocmd FileType ruby map <leader>d orequire 'pry'; binding.pry;puts ""
autocmd FileType ruby map <leader>D Orequire 'pry'; binding.pry;puts ""
autocmd FileType ruby map <leader>s osave_screenshot("/tmp/screenshot.png", full: true)
autocmd FileType ruby map <leader>S Osave_screenshot("/tmp/screenshot.png", full: true)

autocmd FileType javascript map <leader>d odebugger;
autocmd FileType javascript map <leader>D Odebugger;

autocmd BufEnter *.rb syn match error contained "\<binding.pry\>"
autocmd BufEnter *.rb,*.js syn match error contained "\<debugger\>"


" Set a nicer foldtext function
set foldtext=MinimalFoldText()
function! MinimalFoldText()
  let line = getline(v:foldstart)
  let n = v:foldend - v:foldstart + 1
  set fillchars=fold:\ 
  return line . " ⏎ " . n
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       CUSTOM EXTERNAL FUNCTIONALITY                          "
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
"                            PLUGIN CONFIGURATION                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" NETRW (builtin plugin)
let g:netrw_banner=0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,\(^\|\s\s\)ntuser\.\S\+'
autocmd FileType netrw set nolist


" CTRL-P
let g:ctrlp_user_command = [
\  '.git',
\  'cd %s && git ls-files . -co --exclude-standard',
\  'find %s -type f'
\]
map <leader><C-P> <C-P><C-\>w


" NEOMAKE
let g:neomake_javascript_enabled_makers = ['eslint']
autocmd! BufWritePost * Neomake


" GREP (with fugitive)
map <leader>g :Ggrep!  <Bar> copen
map <leader>G :Ggrep!  **/*


" VIM-JSX
let g:jsx_ext_required = 0


" MINI-YANK
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>n <Plug>(miniyank-cycle)
map <leader>N g-


" AIRLINE
let g:airline_left_sep=''
let g:airline_right_sep=''


" EMMET
let g:user_emmet_leader_key='<C-q>'
