return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>e", false }, -- Using mini.files as the default
  },
  opts = {
    explorer = {
      replace_netrw = false, -- Using mini.files as the default
    },
    words = {
      enabled = false, -- The colours of this clash when using autocomplete
    },
  },
}
