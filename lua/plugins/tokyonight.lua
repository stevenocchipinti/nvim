return {
  "folke/tokyonight.nvim",
  opts = {
    style = "night",
    on_highlights = function(hl, c)
      hl.WinSeparator = { fg = c.fg_gutter }
    end,
  },
}
