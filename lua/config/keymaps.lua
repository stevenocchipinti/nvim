-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Easier way to copy and paste from the system clipboard
vim.keymap.set("", "<localleader>p", '"+p', { desc = "Global clipboard paste" })
vim.keymap.set("", "<localleader>y", '"+y', { desc = "Global clipboard copy" })

-- Shortcut for spellcheck
vim.keymap.set(
  "n",
  "<leader>z",
  ":set spell<cr>z=",
  { desc = "Enable spell check and suggestions" }
)
vim.keymap.set(
  "n",
  "<leader>Z",
  ":set nospell<cr>",
  { desc = "Disable spell check" }
)

-- Sudo write
vim.keymap.set("c", "w!!", "w !sudo tee %")

-- Keep the cursor still and highlight matches when pressing *
vim.keymap.set(
  "n",
  "*",
  [[ v:count ? '*' : ':set hls <Bar> execute "keepjumps normal! *" <Bar> call winrestview(' . string(winsaveview()) . ')<CR>' ]],
  { silent = true, expr = true }
)
