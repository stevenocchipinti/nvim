require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "javascript", "typescript", "lua", "json", "json5", "jsdoc", "html", "css",
    "fish", "markdown",
  },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>v",
      node_incremental = "]v",
      scope_incremental = "]V",
      node_decremental = "[v",
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  playground = { enable = true },
}
