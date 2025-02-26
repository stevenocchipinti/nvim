require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
        "javascript", "typescript", "lua", "json", "json5", "jsdoc", "html",
        "css", "fish", "markdown", "vim", "vimdoc", "query"
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = {"javascript"},

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {enable = true},

    indent = {enable = true},

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<leader>v",
            node_incremental = "]v",
            scope_incremental = "]V",
            node_decremental = "[v"
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
    playground = {enable = true}
}

require('ts_context_commentstring').setup {enable_autocmd = false}
require("treesitter-context").setup {enable = true}
