return {
  {
    "razak17/tailwind-fold.nvim",
    opts = { symbol = "󱏿" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
    config = function(_, opts)
      require("tailwind-fold").setup(opts)

      -- Everytime I would toggle the conceallevel with <leader>uc, the
      -- plugins autocmds would re-enable the conceal level.
      -- By doing this, I can toggle the conceal level the standard LazyVim way
      -- instead of using :TailwindFoldEnable and :TailwindFoldDisable
      vim.schedule(function()
        vim.api.nvim_clear_autocmds({ group = "conceal_class_name" })
      end)
    end,
  },
}
