-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

vim.keymap.set("n", "<leader>f", ":Neotree reveal float\n", { silent = true })

-- LuaFormatter off
require("neo-tree").setup {
  filesystem = { follow_current_file = true },
  window = {
    mappings = {
      ["l"] = "open",
      ["h"] = "close_node",
    },
  },
}
-- LuaFormatter on
