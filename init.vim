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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'michaeljsmith/vim-indent-object'
Plug 'chaoren/vim-wordmotion'
Plug 'vim-scripts/matchit.zip'
Plug 'godlygeek/tabular'
Plug 'mattn/emmet-vim'
Plug 'bogado/file-line'
Plug 'mhinz/vim-startify'
Plug 'wincent/terminus'
Plug 'gcmt/taboo.vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Neovim specific
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'hoob3rt/lualine.nvim'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug '~/code/neovim/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'nvim-telescope/telescope.nvim'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'TaDaa/vimade'
Plug 'karb94/neoscroll.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" Technology specific plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
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
set termguicolors       " Use the colours from the terminal
set winblend=5          " Use pseudo-transparency on floating windows
" colorscheme codedark  " This is done in LUA at the bottom now

" Live search and replace!
set inccommand=nosplit

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            CUSTOM FUNCTIONALITY                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Highlight what was just yanked
" Timeout doesn't seem to take effect, maybe next update?
au TextYankPost * silent! lua vim.highlight.on_yank {timeout=50}


" Sudo write
cmap w!! w !sudo tee %


" Shortcut for spellcheck
nnoremap <leader>z :set spell<cr>:Telescope spell_suggest<cr>
nnoremap <leader>Z :set nospell<cr>


" :Q is an accidental error for :q
cnoreabbrev Q q
" Q is another common accidental error to launch :ex mode - which I don't use
nnoremap Q <nop>


" Easier way to copy and paste from the global clipboard
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


" Shortcut and auto source for init.vim
nnoremap <leader>. :e $MYVIMRC<cr>
au! BufWritePost $MYVIMRC source %


" Set a nicer foldtext function
set foldtext=MinimalFoldText()
function! MinimalFoldText()
  let line = getline(v:foldstart)
  let n = v:foldend - v:foldstart + 1
  set fillchars=fold:\ 
  return line . " ⏎ " . n
endfunction


" Format JSON - filter the file through Python to format it
map =j :%!python -m json.tool<cr>


" Format XML - filter the file through xmllint to indent XML
map =x :%!xmllint -format -<cr>


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


" TABOO
let g:taboo_renamed_tab_format = '〔%l〕%m'
nnoremap <leader>rt :TabooRename 


" VIM-WORDMOTION
let g:wordmotion_prefix = '<Leader>'


" FIRENVIM
let g:firenvim_config = {
  \ 'globalSettings': {
  \   'alt': 'all',
  \  },
  \ 'localSettings': {
  \   '.*': {
  \     'cmdline': 'neovim',
  \     'content': 'text',
  \     'priority': 0,
  \     'selector': 'textarea',
  \     'takeover': 'never',
  \   },
  \ }
  \ }
if exists('g:started_by_firenvim')
  set guifont=Caskaydia\ Cove\ Nerd\ Font\ Mono:h20
endif


" LUA PLUGINS
lua <<EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  indent = { enable = true },
  context_commentstring = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>v",
      node_incremental = "]v",
      scope_incremental = "]V",
      node_decremental = "[v",
    }
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner"
      }
    }
  },
  playground = { enable = true }
}

require('lualine').setup {
  options = {
    --theme  = 'codedark',
    theme = 'tokyonight',
    section_separators = {'', ''},
    component_separators = {'', ''}
  },
  sections = {
    lualine_a = {function() return "﬘ "..vim.api.nvim_get_current_buf() end},
    lualine_b = {'branch'},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {},
    lualine_y = {{
      'diagnostics',
      sources = {'coc'},
      symbols = {error = ' ', warn = ' ', info= ' ', hint = ' '},
    }},
    lualine_z = {{'filetype', colored = false}},
  },
  inactive_sections = {
    lualine_a = {function() return "﬘ "..vim.api.nvim_get_current_buf() end},
    lualine_b = {},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
}

require('gitsigns').setup {
  keymaps = {
    ['n ]h'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [h'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},
  },
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '◢' },
    topdelete    = { text = '◥' },
    changedelete = { text = '│' },
  },
}

require('neoscroll').setup {
  mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb'},
}

vim.g.tokyonight_style = "night"
vim.cmd[[colorscheme tokyonight]]
vim.cmd[[hi ColorColumn guibg=#1f2335]]

require('telescope').setup {
  defaults = {
    winblend = 5,
    selection_caret = ' ',
    prompt_prefix = " ",
    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').move_selection_better,
        ["<C-k>"] = require('telescope.actions').move_selection_worse,
      }
    }
  }
}
require('telescope').load_extension('coc')
EOF

" Find files using Telescope command-line sugar.
nnoremap <leader>tt <cmd>Telescope<cr>
nnoremap <leader>tf <cmd>Telescope find_files<cr>
nnoremap <leader>tg <cmd>Telescope live_grep<cr>
nnoremap <leader>tG <cmd>Telescope grep_string<cr>
nnoremap <leader>tb <cmd>Telescope buffers<cr>
nnoremap <leader>th <cmd>Telescope help_tags<cr>
nnoremap <leader>te <cmd>Telescope file_browser<cr>
nnoremap <leader>tq <cmd>Telescope quickfix<cr>
nnoremap <leader>tr i<cmd>Telescope registers<cr>
" imap <C-r> <cmd>Telescope registers<cr>  " Buggy
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope grep_string<cr>
nnoremap <leader>G <cmd>Telescope live_grep<cr>

" COC in Telescope
nnoremap <leader>cm <cmd>Telescope coc mru<cr>
nnoremap <leader>cl <cmd>Telescope coc links<cr>
nnoremap <leader>cc <cmd>Telescope coc commands<cr>
" nnoremap <leader>cc <cmd>Telescope coc locations<cr>
nnoremap <leader>cr <cmd>Telescope coc references<cr>
nnoremap <leader>cd <cmd>Telescope coc definitions<cr>
nnoremap <leader>cD <cmd>Telescope coc declarations<cr>
nnoremap <leader>ci <cmd>Telescope coc implementations<cr>
nnoremap <leader>ct <cmd>Telescope coc type_definitions<cr>
nnoremap <leader>cg <cmd>Telescope coc diagnostics<cr>
nnoremap <leader>ca <cmd>Telescope coc code_actions<cr>
" nnoremap <leader>cc <cmd>Telescope coc line_code_actions<cr>
nnoremap <leader>cA <cmd>Telescope coc file_code_actions<cr>
nnoremap <leader>cs <cmd>Telescope coc document_symbols<cr>
nnoremap <leader>cS <cmd>Telescope coc workspace_symbols<cr>
nnoremap <leader>cG <cmd>Telescope coc workspace_diagnostics<cr>

