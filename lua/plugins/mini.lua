local gen_spec = require("mini.ai").gen_spec

return {
  {
    "echasnovski/mini.pairs",
    opts = function(_, opts)
      -- This code only completes the pair if the cursor is at the end of the
      -- line, chatGPT wrote it but I want to see if this stops the annoying
      -- behaviour of autocompleting a closing bracket when I'm just adding a
      -- starting bracket for a closing bracket that already exists.

      -- Disable default character-based skip logic
      opts.skip_next = nil

      -- We'll save a reference to the original open function later
      local original_open = nil

      -- Schedule override after mini.pairs has been set up
      vim.schedule(function()
        local pairs = require("mini.pairs")
        original_open = original_open or pairs.open

        ---@diagnostic disable-next-line: duplicate-set-field
        pairs.open = function(pair, neigh_pattern)
          local line = vim.api.nvim_get_current_line()
          local col = vim.fn.col(".")

          -- If the cursor is not at the end of the line, skip pairing
          if col <= #line then
            return pair:sub(1, 1)
          end

          -- Call the original open function
          return original_open(pair, neigh_pattern)
        end
      end)
    end,
  },
  {
    "echasnovski/mini.files",
    version = false,
    lazy = false,
    opts = {
      -- g? shows the defaults
      mappings = {
        close = "<ESC>",
        go_in = "L",
        go_in_plus = "l",
      },
      options = {
        permanent_delete = false,
        use_as_default_explorer = true,
      },
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 80,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
  },
  {
    "echasnovski/mini.surround",
    opts = {
      n_lines = 300,
    },
  },
  {
    "echasnovski/mini.ai",
    opts = {
      custom_textobjects = {
        -- Keys and values for CSS
        k = { "^[ ]*().-():" },
        v = { ":[ ]*().-();" },

        -- TODO: Keys and values for JS
        -- These need to have defined treesitter queries
        --
        -- K = gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
        -- V = gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
      },
    },
  },
  {
    "echasnovski/mini.align",
    version = false,
    opts = {
      mappings = {
        start = "<localleader>a",
        start_with_preview = "<localleader>A",
      },
    },
  },
}
