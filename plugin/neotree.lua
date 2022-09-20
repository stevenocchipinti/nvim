-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

vim.keymap.set("n", "<leader>f", ":Neotree reveal float\n", { silent = true })

require("neo-tree").setup {
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
  },
  popup_border_style = "rounded",
  window = {
    mappings = {
      ["l"] = "open",
      ["h"] = "close_node",
      ["<esc>"] = "close_window",
    },
  },
}
