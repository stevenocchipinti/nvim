require("tokyonight").setup {
    style = "night",
    on_highlights = function(hl, c)
        hl.WinSeparator = {fg = c.fg_gutter}
        hl.ColorColumn = {bg = c.bg_dark}
    end
}

vim.cmd [[ colorscheme tokyonight ]]
