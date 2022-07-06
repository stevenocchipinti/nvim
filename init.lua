--
--             ███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗
--             ████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║
--             ██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║
--             ██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║
--             ██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║
--             ╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝
--
--                  https://github.com/stevenocchipinti/nvim
--

-- NOTE: Plugin config in the plugin directory
require "packer_bootstrap"
require("packer").startup {
  function(use)
    use "tpope/vim-commentary"
    use "tpope/vim-fugitive"
    use "tpope/vim-surround"
    use "tpope/vim-repeat"
    use "tpope/vim-unimpaired"
    use "michaeljsmith/vim-indent-object"
    use "chaoren/vim-wordmotion"
    use "godlygeek/tabular"
    use "mattn/emmet-vim"
    use "bogado/file-line"
    use "mhinz/vim-startify"
    use "wincent/terminus"
    use "gcmt/taboo.vim"
    use "romainl/vim-cool"

    -- Neovim specific
    use { "neoclide/coc.nvim", branch = "release" }
    use "folke/tokyonight.nvim"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "nvim-lualine/lualine.nvim"
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-treesitter/playground"
    use "nvim-telescope/telescope.nvim"
    use "fannheyward/telescope-coc.nvim"
    use "TaDaa/vimade"
    use "karb94/neoscroll.nvim"
    use "lewis6991/gitsigns.nvim"
    use {
      "glacambre/firenvim",
      run = function()
        vim.fn["firenvim#install"](0)
      end,
    }
  end,
  config = {
    display = { open_fn = require("packer.util").float },
  },
}

--------------------------------------------------------------------------------
--                           STANDARD VIM SETTINGS                            --
--------------------------------------------------------------------------------

vim.opt.tabstop = 2 -- Use 2 spaces for tab chars
vim.opt.shiftwidth = 2 -- Use 2 spaces for indentation
vim.opt.expandtab = true -- Use spaces instead of tab characters
vim.opt.wrap = false -- (Dont) Wrap the display lines (not actual text)
vim.opt.number = true -- Show line numbers
vim.opt.splitright = true -- Open vertical splits on the right
vim.opt.splitbelow = true -- Open the horizontal split below
vim.opt.ruler = true -- Show row and column in status bar
vim.opt.showcmd = true -- Show operator pending commands in statusbar
vim.opt.ignorecase = true -- Case insensitive search by default
vim.opt.smartcase = true -- Case sensitive when containing any uppercase
vim.opt.scrolloff = 3 -- Always show lines at the top & bottom
vim.opt.colorcolumn = "81" -- Highlight the 81st column
vim.opt.cursorline = true -- Highlight the line which the cursor is on
vim.opt.joinspaces = false -- Use 1 space after '.' when joining lines
vim.opt.shiftround = true -- Indent to the closest shiftwidth
vim.opt.secure = true -- Make sure those project .vimrc's are safe
vim.opt.mouse = "a" -- Enable the mouse
vim.opt.list = true -- Show `listchars` characters
vim.opt.laststatus = 3 -- One status bas per window
vim.opt.listchars = { tab = "├─", trail = "·" }
vim.opt.showbreak = "⤿"
vim.opt.encoding = "UTF-8"

-- Make vim remember undos, even when the file is closed!
vim.opt.undofile = true -- Save undo's after file closes
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undo" -- where to save undo histories
vim.opt.undolevels = 1000 -- How many undos
vim.opt.undoreload = 10000 -- number of lines to save for undo

-- Live search and replace!
vim.opt.inccommand = "nosplit"
