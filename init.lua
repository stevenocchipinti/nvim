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
--------------------------------------------------------------------------------
--          NOTE: The rest of the config is in the plugin directory           --
--------------------------------------------------------------------------------
require "packer_bootstrap"
require("packer").startup {
  function(use)
    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-treesitter/playground"

    -- LSP
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "onsails/lspkind.nvim"
    use "jose-elias-alvarez/null-ls.nvim"
    use "jose-elias-alvarez/typescript.nvim"
    use "aca/emmet-ls"

    -- Autocomplete
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"

    -- Snippets (needed for nvim-cmp above)
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"

    -- Floating file browser
    use { "nvim-neo-tree/neo-tree.nvim", branch = "v2.x" }

    -- Fuzzy finder
    use "nvim-telescope/telescope.nvim"

    -- Status and tab bar
    use "nvim-lualine/lualine.nvim"
    use "nanozuki/tabby.nvim"

    -- Colour scheme
    use "folke/tokyonight.nvim"

    -- Git (diff, blame, signs, etc.)
    use "lewis6991/gitsigns.nvim"
    use "tpope/vim-fugitive"

    -- Misc
    use "tpope/vim-surround"
    use "tpope/vim-repeat"
    use "tpope/vim-unimpaired"
    use "michaeljsmith/vim-indent-object"
    use "chaoren/vim-wordmotion"
    use "godlygeek/tabular"
    use "bogado/file-line"
    use "mhinz/vim-startify"
    use "romainl/vim-cool"
    use "TaDaa/vimade"
    use "karb94/neoscroll.nvim"
    use "rcarriga/nvim-notify"
    use {
      "numToStr/Comment.nvim",
      config = function() require("Comment").setup() end,
    }

    use {
      "glacambre/firenvim",
      run = function() vim.fn["firenvim#install"](0) end,
    }

    -- Dependencies for other plugins
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "MunifTanjim/nui.nvim"
    use "kyazdani42/nvim-web-devicons"
  end,
  config = { display = { open_fn = require("packer.util").float } },
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
vim.opt.signcolumn = "yes" -- Always show the gutter (git signs and diagnostics)
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

--------------------------------------------------------------------------------
--                                  KEY MAPS                                  --
--------------------------------------------------------------------------------

-- Easier way to copy and paste from the system clipboard
vim.keymap.set("", "<leader>p", "\"+p")
vim.keymap.set("", "<leader>y", "\"+y")
-- Y should act like C and D!
vim.keymap.set("n", "Y", "y$")

-- Shortcut for spellcheck
vim.keymap.set("n", "<leader>z", ":set spell<cr>:Telescope spell_suggest<cr>")
vim.keymap.set("n", "<leader>Z", ":set nospell<cr>")

-- Remove un-needed whitespace
vim.keymap.set(
  "n", "=w", function()
    if not vim.o.binary and vim.o.filetype ~= "diff" then
      local current_view = vim.fn.winsaveview()
      vim.cmd [[keeppatterns %s/\s\+$//e]]
      vim.fn.winrestview(current_view)
    end
  end
)

-- Sudo write
vim.keymap.set("c", "w!!", "w !sudo tee %")

-- Keep the cursor still and highlight matches when pressing *
vim.keymap.set(
  "n", "*",
    [[ v:count ? '*' : ':set hls <Bar> execute "keepjumps normal! *" <Bar> call winrestview(' . string(winsaveview()) . ')<CR>' ]],
    { silent = true, expr = true }
)

--------------------------------------------------------------------------------
--                                AUTOCOMMANDS                                --
--------------------------------------------------------------------------------

-- Highlight what was just yanked
vim.api.nvim_create_autocmd(
  "TextYankPost", { command = "silent! lua vim.highlight.on_yank()" }
)

-- Better Markdown file and git commit defaults
-- autocmd BufNewFile,BufRead requirements*.txt set ft=python
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
    { pattern = "*.mdx", command = "setlocal ft=markdown" }
)
vim.api.nvim_create_autocmd(
  "FileType", {
    pattern = { "octopress", "markdown", "gitcommit" },
    command = "setlocal spell",
  }
)
vim.api.nvim_create_autocmd(
  "FileType", {
    pattern = { "octopress", "markdown", "gitcommit" },
    command = "setlocal textwidth=80",
  }
)
vim.api.nvim_create_autocmd(
  "FileType", {
    pattern = { "octopress", "markdown", "gitcommit" },
    command = "nnoremap <leader>= yyp:s/./=/g<cr>",
  }
)
vim.api.nvim_create_autocmd(
  "FileType", {
    pattern = { "octopress", "markdown", "gitcommit" },
    command = "nnoremap <leader>- yyp:s/./-/g<cr>",
  }
)

--------------------------------------------------------------------------------
--                 STUFF I COULDN'T WORK OUT HOW TO DO IN LUA                 --
--------------------------------------------------------------------------------

-- :Q is an accidental error for :q
vim.cmd "cnoreabbrev Q q"

-- Set a nicer foldtext function
vim.cmd [[
set foldtext=MinimalFoldText()
function! MinimalFoldText()
  let line = getline(v:foldstart)
  let n = v:foldend - v:foldstart + 1
  set fillchars=fold:\ 
  return line . " ⏎ " . n
endfunction 
]]
