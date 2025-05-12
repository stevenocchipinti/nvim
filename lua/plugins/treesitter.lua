return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            -- There are some custom text objects configured with mini.ai
            ["ac"] = "@comment.outer", -- These normally default to @class
            ["ic"] = "@comment.outer", -- @comment.inner not supported in TS/JS
            ["ak"] = "@assignment.lhs",
            ["ik"] = "@assignment.lhs",
            ["av"] = "@assignment.rhs",
            ["iv"] = "@assignment.rhs",
          },
        },
        move = {
          enable = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@comment.outer",
            ["]a"] = "@parameter.inner",
            ["]l"] = "@loop.inner",
            ["]r"] = "@return.inner",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@comment.outer",
            ["[a"] = "@parameter.inner",
            ["[l"] = "@loop.inner",
            ["[r"] = "@return.inner",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@comment.outer",
            ["]A"] = "@parameter.inner",
            ["]L"] = "@loop.inner",
            ["]R"] = "@return.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@comment.outer",
            ["[A"] = "@parameter.inner",
            ["[L"] = "@loop.inner",
            ["[R"] = "@return.inner",
          },
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "ac", mode = { "o", "x" }, desc = "Comment" }, -- Not overriding class for some reason
        { "ic", mode = { "o", "x" }, desc = "Comment" }, -- Not overriding class for some reason
        { "ak", mode = { "o", "x" }, desc = "Assignment LHS (key)" },
        { "ik", mode = { "o", "x" }, desc = "Assignment LHS (key)" },
        { "av", mode = { "o", "x" }, desc = "Assignment RHS (value)" },
        { "iv", mode = { "o", "x" }, desc = "Assignment RHS (value)" },
      },
    },
  },
}
