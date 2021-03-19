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
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/matchit.zip'
Plug 'godlygeek/tabular'
Plug 'mattn/emmet-vim'
Plug 'bogado/file-line'
Plug 'mhinz/vim-startify'
Plug 'wincent/terminus'
Plug 'blueyed/vim-diminactive'
Plug 'ryanoasis/vim-devicons'

" Technology specific plugins
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
set colorcolumn=81      " Highlight the 81st column (shorthand = :set cc=81)
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
" colorscheme tomorrow-night
colorscheme codedark


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              NEOVIM SPECIFIC                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("nvim")
  " Live search and replace!
  set inccommand=nosplit

  " Highlight what was just yanked
  if exists('##TextYankPost')
    " Timeout doesn't seem to take effect, maybe next update?
    au TextYankPost * silent! lua vim.highlight.on_yank {timeout=50}
  endif

  cmap w!! w !sudo tee %
else
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
map <leader>/ :set hls!<bar>set hls?


" Subword navigation for camelCase words
map <leader>w /\<\\|[A-Z]
map <leader>e /\>\\|[A-Z]
map <leader>b ?\<\\|[A-Z]


" Shortcuts for debugging
autocmd BufEnter *.rb,*.js syn match error contained "\<debugger\>"
autocmd FileType javascript map <leader>d odebugger;
autocmd FileType javascript map <leader>D Odebugger;


" Better Markdown file defaults
autocmd BufNewFile,BufRead *.markdown,*.textile setlocal filetype=octopress
autocmd FileType octopress,markdown map <leader>= yyp:s/./=/g
autocmd FileType octopress,markdown map <leader>- yyp:s/./-/g
autocmd FileType octopress,markdown,gitcommit setlocal spell
autocmd FileType octopress,markdown,gitcommit setlocal textwidth=80


" auto source when writing to init.vm alternatively you can run :source $MYVIMRC
au! BufWritePost $MYVIMRC source %


" Styled components theme helper
map <leader>t a${({ theme }) => theme.};hi


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


" Format XML - filter the file through xmllint to indent XML
map =x :%!xmllint -format -


" Remove un-needed whitespace
map <silent> =w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            PLUGIN CONFIGURATION                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" COC-NVIM (lot's here, needs it's own file)
source $HOME/.config/nvim/coc.vim


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


" GREP (with fugitive)
map <leader>g :Ggrep!  <Bar> copen
map <leader>G :Ggrep!  **/*


" AIRLINE
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_powerline_fonts = 1
let g:airline_section_a=''
let g:airline_section_x=''
let g:airline_section_y=''
let g:airline_section_z=''


" EMMET
" `<C-q>` is a decent, less used alternative to `<C-y>` (the default)
" I use `<C-y>` a fair bit to scroll the buffer and don't want the lag.
" `<C-\>` is an even better leader key!
let g:user_emmet_leader_key='<C-\>'
" and <C-\><C-\> is easier than <C-\>,
imap <C-\><C-\> <plug>(emmet-expand-abbr)


" STARTIFY
let g:startify_custom_header = [
  \ '    _ __   ___  _____   _(_)_ __ ___   ',
  \ '   | `_ \ / _ \/ _ \ \ / / | `_ ` _ \  ',
  \ '   | | | |  __/ (_) \ V /| | | | | | | ',
  \ '   |_| |_|\___|\___/ \_/ |_|_| |_| |_| ',
  \]
let g:startify_session_persistence = 1
let g:startify_session_autoload = 1
let g:startify_change_to_vcs_root = 1
