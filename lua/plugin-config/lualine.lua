local bufferText =
  function() return "󰧭 " .. vim.api.nvim_get_current_buf() end

local buffer = { bufferText, separator = { left = "", right = "" } }

local branch = { "branch", icon = "" }

local filename = {
  "filename",
  path = 1,
  symbols = { modified = "  ", readonly = "  " },
}

local diagnostics = {
  "diagnostics",
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
}

local filetype = {
  "filetype",
  disable_text = true,
  colored = false,
  right_padding = 2,
  separator = { left = "", right = "" },
}

require("lualine").setup {
  options = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { buffer },
    lualine_b = { branch },
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
    lualine_z = { diagnostics },
  },
}
