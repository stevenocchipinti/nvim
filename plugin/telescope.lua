local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local wk = require("which-key")

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

wk.register(
  {
    ["<leader>t"] = {
      name = "+Telescope",
      t = { "<cmd>Telescope<cr>", "Open Telescope" },
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      h = { "<cmd>Telescope help_tags<cr>", "Help" },
      q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
      r = { "<cmd>Telescope registers<cr>", "Registers" },
      f = { "<cmd>Telescope find_files<cr>", "Files" },
      g = { "<cmd>Telescope live_grep<cr>", "Grep" },
      G = { "<cmd>Telescope grep_string<cr>", "Grep under cursor" },
    },

    -- Grep
    ["<leader>g"] = {
      name = "+Grep",
      g = { "<cmd>Telescope live_grep<cr>", "Grep" },
      G = { "<cmd>Telescope grep_string<cr>", "Grep under cursor" },
    },

    -- Files
    ["<C-p>"] = { "<cmd>Telescope find_files<cr>", "Files" },

    -- Todos
    ["<leader>tT"] = { "<cmd>TodoTelescope<cr>", "Todos" },

    -- Neovim Config
    ["<leader>."] = {
      function()
        require("telescope.builtin").find_files(
          { search_dirs = { "~/.config/nvim" } }
        )
      end,
      "Open Neovim config",
    },
  }
)
