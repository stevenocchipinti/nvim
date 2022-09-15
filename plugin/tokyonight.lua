require("tokyonight").setup {
  style = "night",
  on_highlights = function(hl, c) hl.ColorColumn = { bg = c.bg_dark } end,
}

vim.cmd [[ colorscheme tokyonight ]]
