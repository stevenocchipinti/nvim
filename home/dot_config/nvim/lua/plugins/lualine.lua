local buffer_or_macro = {
  function()
    local rec = vim.fn.reg_recording()
    if rec == "" then
      return "󰧭 " .. vim.api.nvim_get_current_buf()
    else
      return "  " .. rec
    end
  end,
  separator = { left = "", right = "" },
}

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

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { buffer_or_macro },
        lualine_b = { branch },
        lualine_c = { filename },
        lualine_x = {},
        lualine_y = { diagnostics },
        lualine_z = { filetype },
      },
      inactive_sections = {
        lualine_a = { buffer_or_macro },
        lualine_b = {},
        lualine_c = { filename },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { diagnostics },
      },
    },
  },
}
