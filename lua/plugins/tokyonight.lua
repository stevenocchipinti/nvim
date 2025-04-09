return {
  "folke/tokyonight.nvim",
  opts = {
    style = "night",
    on_highlights = function(hl, c)
      hl.WinSeparator = { fg = c.fg_gutter }
      hl.TabLineFill = { bg = c.black }
      hl.LineNr = { bg = c.black }
      hl.CursorLineNr = { bg = c.black, fg = c.orange }
    end,
  },
}
