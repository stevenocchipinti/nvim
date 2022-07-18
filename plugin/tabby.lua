local tab = require("tabby.tab")
local win = require("tabby.win")
local highlight = require("tabby.module.highlight").extract
local devicons = require "nvim-web-devicons"

local hl_tabline_fill = highlight("TabLineFill")
local hl_tabline = highlight("TabLine")
local hl_tabline_sel = highlight("TabLineSel")

local function some(table, predicate)
  local result = false
  for key, value in pairs(table) do
    if predicate(key, value) then result = true end
  end
  return result
end

-- Shows the filename with the path
-- Unless it's index.ext, then it shows parent-dir/  instead
local function buffer_name(focus_win)
  local name = ""

  local buf_name = win.get_bufname(focus_win)
  local icon = devicons.get_icon(buf_name)

  local buf_handle = vim.api.nvim_win_get_buf(focus_win)
  local buf_path = vim.api.nvim_buf_get_name(buf_handle)
  local path_and_index, n = string.gsub(
    buf_path, ".+/(.+)/index%.%w+$", "%1/ "
  )

  name = n == 0 and buf_name or path_and_index
  if icon then name = name .. " " .. icon end
  return name
end

local function number_icon(n)
  local icons = {
    "",
    "  ",
    "  ",
    "  ",
    "  ",
    "  ",
    "  ",
    "  ",
    "  ",
    "  ",
  }

  if n > 9 then
    return icons[10]
  elseif n > 1 then
    return icons[n]
  else
    return ""
  end
end

local function tab_label(tabid)
  local windows = win.all_in_tab(tabid)
  local focus_win = tab.get_current_win(tabid)
  local buf_name_custom = tab.get_raw_name(tabid)
  local buf_name = buffer_name(focus_win)

  local name = number_icon(#windows)

  local function has_modified_buf(_, window)
    local buf = vim.api.nvim_win_get_buf(window)
    return vim.api.nvim_buf_get_option(buf, "modified")
  end
  if some(windows, has_modified_buf) then name = name .. " " end

  if vim.api.nvim_win_get_config(focus_win).relative ~= "" then
    name = name .. " [Floating]"
  elseif buf_name_custom ~= "" then
    name = name .. " " .. buf_name_custom
  else
    name = name .. " " .. buf_name
  end

  return name .. " "
end

local tabline = {
  hl = "lualine_c_normal",
  layout = "tab_only",
  active_tab = {
    label = function(tabid)
      return {
        tab_label(tabid),
        hl = { fg = hl_tabline_sel.fg, bg = hl_tabline_sel.bg, style = "bold" },
      }
    end,
    left_sep = { "",
    hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
    right_sep = {
      "",
      hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg },
    },
  },
  inactive_tab = {
    label = function(tabid)
      return { tab_label(tabid),
      hl = { fg = hl_tabline.fg, bg = hl_tabline.bg } }
    end,
    left_sep = { " ", hl = { bg = hl_tabline_fill.bg } },
    right_sep = { " ", hl = { bg = hl_tabline_fill.bg } },
  },
}

require("tabby").setup({ tabline = tabline, opt = { show_at_least = 2 } })
