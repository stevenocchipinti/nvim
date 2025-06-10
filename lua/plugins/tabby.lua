local colors = require("tokyonight.colors").setup()
local util = require("tokyonight.util")

-- local theme = {
--   fill = "TabLineFill",
--   fg_active_error = util.darken(colors.red, 0.3),
--   fg_active_warn = util.darken(colors.yellow, 0.3),
--   fg_active_normal = colors.black,
--   fg_active_secondary = colors.blue,
--   fg_inactive_error = util.darken(colors.red, 0.3),
--   fg_inactive_warn = util.darken(colors.yellow, 0.3),
--   fg_inactive_normal = "#3B4261",
--   bg_primary_active = colors.blue,
--   bg_primary_inactive = colors.bg_dark,
--   bg_secondary_active = "#3B4261",
--   bg_secondary_inactive = colors.bg_dark,
-- }

local theme = {
  fill = "TabLineFill",
  fg_active_error = util.darken(colors.red, 0.3),
  fg_active_warn = util.darken(colors.yellow, 0.3),
  fg_active_normal = colors.black,
  fg_active_secondary = colors.blue,
  fg_inactive_error = util.darken(colors.red, 0.6),
  fg_inactive_warn = util.darken(colors.yellow, 0.6),
  fg_inactive_normal = colors.blue,
  bg_primary_active = colors.blue,
  bg_primary_inactive = util.darken("#3B4261", 0.3),
  bg_secondary_active = "#3B4261",
  bg_secondary_inactive = util.darken("#3B4261", 0),
}

local function has_errors(bufid)
  return #vim.diagnostic.get(
    bufid,
    { severity = vim.diagnostic.severity.ERROR }
  ) > 0
end

local function has_warnings(bufid)
  return #vim.diagnostic.get(
      bufid,
      { severity = vim.diagnostic.severity.WARN }
    ) > 0
end

local function get_nice_name(tabid)
  local cur_win = vim.api.nvim_tabpage_get_win(tabid)
  local cur_buf = vim.api.nvim_win_get_buf(cur_win)
  local full_path = vim.api.nvim_buf_get_name(cur_buf or 0)

  if full_path == nil or full_path == "" then
    return ""
  end

  -- :t modifier extracts the filename component
  local filename = vim.fn.fnamemodify(full_path, ":t")

  -- Check if the filename starts with 'index.' and has an extension
  -- Using Lua pattern: ^index%.%w+$
  -- ^ = start of string
  -- index = literal 'index'
  -- %. = literal '.' (must escape the magic character %)
  -- %w+ = one or more alphanumeric characters (typical for extensions)
  -- $ = end of string
  if filename:match("^index%.%w+$") then
    -- It's an index file, get the parent directory name
    local path = vim.fn.fnamemodify(full_path, ":h")
    local parent_dir = vim.fn.fnamemodify(path, ":t")
    local info_char = "ℹ"

    -- If the parent directory name is empty or '.', it means the index file
    -- is in the root directory (e.g., /index.html) or the current working
    -- directory without a specified parent (e.g., index.html).
    -- In this case, just show the info character.
    if parent_dir == "" or parent_dir == "." then
      return info_char .. filename:match("%..+$")
    else
      -- Otherwise, combine the parent directory name and the info character and the file extension
      return parent_dir .. "/" .. info_char .. filename:match("%..+$")
    end
  else
    -- Not an index file, return only the filename
    return filename
  end
end

local line = function(line)
  return {
    line.tabs().foreach(function(tab)
      local cur_win = tab.current_win()
      local cur_buf = cur_win.buf()
      local has_changes = cur_buf.is_changed()
      local filename = cur_buf.name()
      local icon = cur_win.file_icon()
      local has_many_windows = #tab.wins().wins > 1

      local diagnostic_icon
      if has_errors(cur_buf.id) then
        diagnostic_icon = "  "
      elseif has_warnings(cur_buf.id) then
        diagnostic_icon = "  "
      else
        diagnostic_icon = ""
      end

      local fg_active
      if has_errors(cur_buf.id) then
        fg_active = theme.fg_active_error
      elseif has_warnings(cur_buf.id) then
        fg_active = theme.fg_active_warn
      else
        fg_active = theme.fg_active_normal
      end

      local fg_inactive
      if has_errors(cur_buf.id) then
        fg_inactive = theme.fg_inactive_error
      elseif has_warnings(cur_buf.id) then
        fg_inactive = theme.fg_inactive_warn
      else
        fg_inactive = theme.fg_inactive_normal
      end

      local primary = tab.is_current()
          and { bg = theme.bg_primary_active, fg = fg_active }
        or { bg = theme.bg_primary_inactive, fg = fg_inactive }
      local secondary = tab.is_current()
          and { bg = theme.bg_secondary_active, fg = theme.fg_active_secondary }
        or { bg = theme.bg_secondary_inactive, fg = fg_inactive }

      local name
      if require("tabby.module.api").is_float_win(cur_win.id) then
        name = " 󰖲 "
      elseif filename == "[No Name]" then
        name = " [] "
      else
        name = string.format("%s %s", icon, tab.name())
      end

      local tab_parts = {}

      table.insert(tab_parts, {
        line.sep("", primary, theme.fill),
        {
          name,
          diagnostic_icon,
          (has_changes and "  "),
        },
        line.sep("", primary, has_many_windows and secondary or theme.fill),
        hl = primary,
      })

      if has_many_windows then
        table.insert(tab_parts, {
          line.sep("", secondary, "lualine_b_normal"),
          " " .. #tab.wins().wins,
          line.sep(" ", secondary, theme.fill),
          hl = secondary,
        })
      else
        table.insert(tab_parts, {
          "  ",
        })
      end

      return tab_parts
    end),
  }
end

return {
  "nanozuki/tabby.nvim",
  enabled = true,
  config = function(_, opts)
    require("mini.icons").mock_nvim_web_devicons()
    require("tabby").setup(opts)
  end,
  opts = {
    line = line,
    option = {
      tab_name = {
        name_fallback = get_nice_name,
      },
    },
  },
}
