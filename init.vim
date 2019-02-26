""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                              "
"      _ __   ___  _____   _(_)_ __ ___       ___ ___  _ __  / _(_) __ _       "
"     | '_ \ / _ \/ _ \ \ / / | '_ ` _ \     / __/ _ \| '_ \| |_| |/ _` |      "
"     | | | |  __/ (_) \ V /| | | | | | |   | (_| (_) | | | |  _| | (_| |      "
"     |_| |_|\___|\___/ \_/ |_|_| |_| |_|    \___\___/|_| |_|_| |_|\__, |      "
"                                                                  |___/       "
"                                                                              "
"          http://stevenocchipinti.com                                         "
"          https://github.com/stevenocchipinti/nvim                            "
"                                                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/matchit.zip'
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'mattn/emmet-vim'
Plug 'bogado/file-line'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

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
Plug 'digitaltoad/vim-pug'
Plug 'StanAngeloff/php.vim'
Plug 'styled-components/vim-styled-components'
Plug 'hail2u/vim-css3-syntax'
Plug 'dag/vim-fish'
Plug 'metakirby5/codi.vim'
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
set showcmd             " Show partial commands (such as 'd' when typing 'dw')
set ignorecase          " Case insensitive search by default
set smartcase           " Use case sensitive search in a capital letter is used
set nohlsearch          " Don't highlight searches, useful for jumping around
set scrolloff=3         " Number of lines to always show at at the top & bottom
set colorcolumn=81,91   " Highlight the 81st column (shorthand = :set cc=81)
set cursorline          " Highlight the line which the cursor is on
set nojoinspaces        " Use 1 space after "." when joining lines instead of 2
set shiftround          " Indent to the closest shiftwidth
set secure              " Make sure those project .vimrc's are safe
set mouse=a             " Enable the mouse
set list                " Show `listchars` characters
set listchars=tab:├─,trail:·
set showbreak=⤿
set encoding=UTF-8

" Make vim remember undos, even when the file is closed!
set undofile            " Save undo's after file closes
set undodir=~/.vim/undo " where to save undo histories
set undolevels=1000     " How many undos
set undoreload=10000    " number of lines to save for undo

" COLOR!
colorscheme tomorrow-night


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     NEOVIM SPECIFIC (mostly bugfixes)                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("nvim")
  " Live search and replace!
  set inccommand=nosplit

  " Use pipe in insert-mode and a block in normal-mode
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

  " BUG: netrw is really slow
  " No workaround yet except to use another file explorer

  " BUG: ctrl-l doesn't repaint the screen when its messed up by resizing
  " Temp workaround for <C-l> -- https://github.com/neovim/neovim/issues/3929
  map <C-l> :mode

  " BUG: Interactive shell commands don't work with the terminal anymore
  " Temp workaround for :W -- https://github.com/neovim/neovim/issues/1716
  command! W w !sudo -n tee % > /dev/null || echo "Press <leader>s to authenticate and try again"
  map <leader>s :new:term sudo true

else
  " To use different cursor modes in iTerm2
  " Ref: http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"

  " When you dont have write access, :W will write with sudo
  " Without this, you could use ':w !sudo tee %'
  command! W w !sudo tee % > /dev/null

  " Neovim has this on by default, but vim does not
  set t_Co=256
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          CUSTOM VIM FUNCTIONALITY                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Shortcut for spellcheck
map <leader>z :set spellz=
map <leader>Z :set nospell


" :Q is an accidental error for :q
cnoreabbrev Q q


" Q is another common accidental error to launch :ex mode - which I don't use
nnoremap Q <nop>


" Easier way to copy and paste from the global clipboard
map <leader>p "+p
map <leader>y "+y
" Y should act like C and D!
map Y y$


" Easier way to make a blank line but not go into insert mode
map <leader>o o
map <leader>O O


" Easier way to toggle highlighted search
map <leader>h :set hls!<bar>set hls?


" Subword navigation for camelCase words
map <leader>w /\<\\|[A-Z]
map <leader>e /\>\\|[A-Z]
map <leader>b ?\<\\|[A-Z]


" Shortcuts for debugging
autocmd FileType ruby map <leader>d orequire 'pry'; binding.pry;puts ""
autocmd FileType ruby map <leader>D Orequire 'pry'; binding.pry;puts ""
autocmd FileType ruby map <leader>s osave_screenshot("/tmp/screenshot.png", full: true)
autocmd FileType ruby map <leader>S Osave_screenshot("/tmp/screenshot.png", full: true)
autocmd FileType javascript map <leader>d odebugger;
autocmd FileType javascript map <leader>D Odebugger;
autocmd BufEnter *.rb syn match error contained "\<binding.pry\>"
autocmd BufEnter *.rb,*.js syn match error contained "\<debugger\>"


" Filetype specific
autocmd BufNewFile,BufRead *.markdown,*.textile setlocal filetype=octopress
autocmd FileType octopress,markdown map <leader>= yyp:s/./=/g
autocmd FileType octopress,markdown map <leader>- yyp:s/./-/g
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
\  'cd %s; and git ls-files . -co --exclude-standard',
\  'find %s -type f'
\]
map <leader><C-P> <C-P><C-\>w


" NERDTREE PLUGIN - (mnemonic: Files)
nmap <leader>f :NERDTreeToggle
nmap <leader>F :NERDTreeFind


" VIM-NERDTREE-SYNTAX-HIGHLIGHT PLUGIN
let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['md'] = "834F79"
let g:NERDTreeExtensionHighlightColor['sh'] = "8FAA54"


" ALE
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\}
let g:ale_fix_on_save = 1
command! WW noautocmd w " To save without formatting (or use `:noa w`)
nmap <silent> <leader>a <Plug>(ale_next_wrap)
nmap <silent> <leader>A <Plug>(ale_previous_wrap)

" GREP (with fugitive)
map <leader>g :Ggrep!  <Bar> copen
map <leader>G :Ggrep!  **/*


" VIM-JSX
let g:jsx_ext_required = 0


" VIM-CSS3-SYNTAX
" augroup VimCSS3Syntax
"   autocmd!
"   autocmd FileType css,javascript.jsx setlocal iskeyword+=-
" augroup END


" AIRLINE
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_powerline_fonts = 1


" EMMET
" `<C-q>` is a decent, less used alternative to `<C-y>` (the default)
" I use `<C-y>` a fair bit to scroll the buffer and don't want the lag.
"let g:user_emmet_leader_key='<C-q>'
" Even better leader key!
let g:user_emmet_leader_key='<C-\>'


" STARTIFY
let g:startify_session_persistence = 1
