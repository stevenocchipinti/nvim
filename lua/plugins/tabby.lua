-- local MiniIcons = require("mini.icons")

local theme = {
  -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
  fill = "TabLineFill",
  head = "TabLine",
  current_tab = "TabLineSel",
  tab = "TabLine",
  win = "TabLine",
  tail = "TabLine",
}

local line = function(line)
  return {
    {
      line.sep("", theme.head, theme.fill),
    },
    line.tabs().foreach(function(tab)
      local hl = tab.is_current() and theme.current_tab or theme.tab
      return {
        line.sep("", hl, theme.fill),
        tab.name(),
        tab.close_btn(""),
        line.sep("", hl, theme.fill),
        hl = hl,
        margin = " ",
      }
    end),
    -- line.spacer(),
    -- line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
    --   return {
    --     line.sep("", theme.win, theme.fill),
    --     win.buf_name(),
    --     line.sep("", theme.win, theme.fill),
    --     hl = theme.win,
    --     margin = " ",
    --   }
    -- end),
    -- {
    --   line.sep("", theme.tail, theme.fill),
    -- },
    hl = theme.fill,
  }
end

return {
  "nanozuki/tabby.nvim",
  enabled = false,
  opts = {
    line = line,
    -- TODO: Get the standard nvim api for the commented out calls
    name_fallback = function(tabid)
      local wins = vim.api.nvim_tabpage_list_wins(0)
      -- local cur_win = api.get_tab_current_win(tabid)
      local name = ""
      -- if api.is_float_win(cur_win) then
      --   name = "[Floating]"
      -- else
      --   name = win_name.get(cur_win)
      -- end
      if #wins > 1 then
        name = string.format("%s[%d+]", name, #wins - 1)
      end
      return name
    end,
  },
}
