require("lualine").setup {
  options = {
    theme = "tokyonight",
    section_separators = { "", "" },
    component_separators = { "", "" },
  },
  sections = {
    lualine_a = {
      function()
        return "﬘ " .. vim.api.nvim_get_current_buf()
      end,
    },
    lualine_b = { "branch" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {},
    lualine_y = {
      {
        "diagnostics",
        sources = { "coc" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
    },
    lualine_z = { { "filetype", colored = false } },
  },
  inactive_sections = {
    lualine_a = {
      function()
        return "﬘ " .. vim.api.nvim_get_current_buf()
      end,
    },
    lualine_b = {},
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}
