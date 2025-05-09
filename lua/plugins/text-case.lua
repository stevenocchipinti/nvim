return {
  {
    "johmsalas/text-case.nvim",
    opts = {
      default_keymappings_enabled = false,
    },
    -- stylua: ignore start
    keys = {
      { "ga ", "<cmd>lua require('textcase').current_word('to_phrase_case')<CR>"    , desc = "Convert to phrase case" },
      { "ga,", "<cmd>lua require('textcase').current_word('to_comma_case')<CR>"     , desc = "Convert to,comma,case" },
      { "ga.", "<cmd>lua require('textcase').current_word('to_dot_case')<CR>"       , desc = "Convert to.dot.case" },
      { "ga/", "<cmd>lua require('textcase').current_word('to_path_case')<CR>"      , desc = "Convert to/path/case" },
      { "gaC", "<cmd>lua require('textcase').current_word('to_constant_case')<CR>"  , desc = "Convert TO_CONSTANT_CASE" },
      { "gac", "<cmd>lua require('textcase').current_word('to_camel_case')<CR>"     , desc = "Convert toCamelCase" },
      { "gak", "<cmd>lua require('textcase').current_word('to_dash_case')<CR>"      , desc = "Convert to-kebab-case" },
      { "gal", "<cmd>lua require('textcase').current_word('to_lower_case')<CR>"     , desc = "Convert to lower case" },
      { "gap", "<cmd>lua require('textcase').current_word('to_pascal_case')<CR>"    , desc = "Convert ToPascalCase" },
      { "gas", "<cmd>lua require('textcase').current_word('to_snake_case')<CR>"     , desc = "Convert to_snake_case" },
      { "gat", "<cmd>lua require('textcase').current_word('to_title_case')<CR>"     , desc = "Convert To Title Case" },
      { "gau", "<cmd>lua require('textcase').current_word('to_upper_case')<CR>"     , desc = "Convert TO UPPER CASE" },

      { "gA ", "<cmd>lua require('textcase').lsp_rename('to_phrase_case')<CR>"      , desc = "Refactor with LSP to phrase case" },
      { "gA,", "<cmd>lua require('textcase').lsp_rename('to_comma_case')<CR>"       , desc = "Refactor with LSP to,comma,case" },
      { "gA.", "<cmd>lua require('textcase').lsp_rename('to_dot_case')<CR>"         , desc = "Refactor with LSP to.dot.case" },
      { "gA/", "<cmd>lua require('textcase').lsp_rename('to_path_case')<CR>"        , desc = "Refactor with LSP to/path/case" },
      { "gAC", "<cmd>lua require('textcase').lsp_rename('to_constant_case')<CR>"    , desc = "Refactor with LSP TO_CONSTANT_CASE" },
      { "gAc", "<cmd>lua require('textcase').lsp_rename('to_camel_case')<CR>"       , desc = "Refactor with LSP toCamelCase" },
      { "gAk", "<cmd>lua require('textcase').lsp_rename('to_dash_case')<CR>"        , desc = "Refactor with LSP to-kebab-case" },
      { "gAl", "<cmd>lua require('textcase').lsp_rename('to_lower_case')<CR>"       , desc = "Refactor with LSP to lower case" },
      { "gAp", "<cmd>lua require('textcase').lsp_rename('to_pascal_case')<CR>"      , desc = "Refactor with LSP ToPascalCase" },
      { "gAs", "<cmd>lua require('textcase').lsp_rename('to_snake_case')<CR>"       , desc = "Refactor with LSP to_snake_case" },
      { "gAt", "<cmd>lua require('textcase').lsp_rename('to_title_case')<CR>"       , desc = "Refactor with LSP To Title Case" },
      { "gAu", "<cmd>lua require('textcase').lsp_rename('to_upper_case')<CR>"       , desc = "Refactor with LSP TO UPPER CASE" },

      { "gz ", "<cmd>lua require('textcase').operator('to_phrase_case')<CR>"        , desc = "Convert with operator to phrase case" },
      { "gz,", "<cmd>lua require('textcase').operator('to_comma_case')<CR>"         , desc = "Convert with operator to,comma,case" },
      { "gz.", "<cmd>lua require('textcase').operator('to_dot_case')<CR>"           , desc = "Convert with operator to.dot.case" },
      { "gz/", "<cmd>lua require('textcase').operator('to_path_case')<CR>"          , desc = "Convert with operator to/path/case" },
      { "gzC", "<cmd>lua require('textcase').operator('to_constant_case')<CR>"      , desc = "Convert with operator TO_CONSTANT_CASE" },
      { "gzc", "<cmd>lua require('textcase').operator('to_camel_case')<CR>"         , desc = "Convert with operator toCamelCase" },
      { "gzk", "<cmd>lua require('textcase').operator('to_dash_case')<CR>"          , desc = "Convert with operator to-kebab-case" },
      { "gzl", "<cmd>lua require('textcase').operator('to_lower_case')<CR>"         , desc = "Convert with operator to lower case" },
      { "gzp", "<cmd>lua require('textcase').operator('to_pascal_case')<CR>"        , desc = "Convert with operator ToPascalCase" },
      { "gzs", "<cmd>lua require('textcase').operator('to_snake_case')<CR>"         , desc = "Convert with operator to_snake_case" },
      { "gzt", "<cmd>lua require('textcase').operator('to_title_case')<CR>"         , desc = "Convert with operator To Title Case" },
      { "gzu", "<cmd>lua require('textcase').operator('to_upper_case')<CR>"         , desc = "Convert with operator TO UPPER CASE" },
    },
    -- stylua: ignore end

    -- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
    -- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
    -- available after the first executing of it or after a keymap of text-case.nvim has been used.
    lazy = false,
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "gz", icon = "󰬶", group = "+Text case with operator" },
        { "ga", icon = "󰬶", group = "+Text case" },
        { "gA", icon = "󰬶", group = "+Text case with LSP" },
      },
    },
  },
}
