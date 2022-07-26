require("trouble").setup {}

vim.keymap.set(
  "n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true }
)
vim.keymap.set(
  "n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
    { silent = true, noremap = true }
)
vim.keymap.set(
  "n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
    { silent = true, noremap = true }
)
vim.keymap.set(
  "n", "<leader>xl", "<cmd>Trouble loclist<cr>",
    { silent = true, noremap = true }
)
vim.keymap.set(
  "n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
    { silent = true, noremap = true }
)

vim.keymap.set(
  "n", "gR", "<cmd>Trouble lsp_references<cr>",
    { silent = true, noremap = true }
)

require("todo-comments").setup()

vim.keymap.set(
  "n", "<leader>xt", "<cmd>TodoTrouble<cr>", { silent = true, noremap = true }
)
