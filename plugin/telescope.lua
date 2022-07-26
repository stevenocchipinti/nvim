local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

require("telescope").setup {
  defaults = {
    winblend = 5,
    selection_caret = " ",
    prompt_prefix = " ",
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_better,
        ["<C-k>"] = actions.move_selection_worse,
        ["<c-t>"] = trouble.open_with_trouble,
      },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}

vim.keymap.set("n", "<leader>tt", "<cmd>Telescope<cr>")
vim.keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>th", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>tq", "<cmd>Telescope quickfix<cr>")
vim.keymap.set("n", "<leader>tr", "i<cmd>Telescope registers<cr>")

-- Files
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>tf", "<cmd>Telescope find_files<cr>")

-- Grep
vim.keymap.set("n", "<leader>tg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>tG", "<cmd>Telescope grep_string<cr>")
vim.keymap.set("n", "<leader>G", "<cmd>Telescope grep_string<cr>")

-- Todos
vim.keymap.set("n", "<leader>tT", "<cmd>TodoTelescope<cr>")

-- Vim config
vim.keymap.set(
  "n", "<leader>.", function()
    require("telescope.builtin").find_files(
      { search_dirs = { "~/.config/nvim" } }
    )
  end
)
