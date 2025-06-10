return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown.mdx", "markdown", "norg", "rmd", "org", "codecompanion" },
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 3,
      },
      heading = {
        sign = false,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        border = true,
      },
      checkbox = {
        enabled = true,
      },
    },
  },
}
