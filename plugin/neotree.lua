local neotree = require("neo-tree")
local wk = require("which-key")

-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

wk.register(
  {
    ["<leader>f"] = { ":Neotree reveal float\n", "File tree" },
    ["<leader>gs"] = { ":Neotree reveal float git_status\n", "Git status" },
  }
)

neotree.setup {
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
  },
  popup_border_style = "rounded",
  window = { mappings = { ["l"] = "open", ["h"] = "close_node" } },
}
