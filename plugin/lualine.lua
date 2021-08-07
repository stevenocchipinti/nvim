local filename = {
  "filename",
  path = 1,
  symbols = { modified = "  ", readonly = "  " },
}

local buffer = function()
  return "﬘ " .. vim.api.nvim_get_current_buf()
end

local diagnostics = {
  "diagnostics",
  sources = { "coc" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
}

local filetype = { "filetype", colored = false }

require("lualine").setup {
  options = {
    theme = "tokyonight",
    section_separators = { "", "" },
    component_separators = { "", "" },
  },
  sections = {
    lualine_a = { buffer },
    lualine_b = { "branch" },
    lualine_c = { filename },
    lualine_x = {},
    lualine_y = { diagnostics },
    lualine_z = { filetype },
  },
  inactive_sections = {
    lualine_a = { buffer },
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}
