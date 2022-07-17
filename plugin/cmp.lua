vim.cmd [[ set completeopt=menu,menuone,noselect ]]

local cmp = require "cmp"
local lspkind = require("lspkind")

cmp.setup(
  {
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args) require("luasnip").lsp_expand(args.body) end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert(
      {
        ["<C-Space>"] = cmp.mapping.complete({}),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
      }
    ),
    sources = cmp.config.sources(
      {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer", keyword_length = 5 },
      }
    ),
  }
)

-- Set configuration for specific filetype.
cmp.setup.filetype(
  "gitcommit", {
    sources = cmp.config
      .sources({ { name = "cmp_git" } }, { { name = "buffer" } }),
  }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  "/",
    { mapping = cmp.mapping.preset.cmdline(), sources = { { name = "buffer" } } }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  ":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config
      .sources({ { name = "path" } }, { { name = "cmdline" } }),
  }
)

-- Custom lsp icons
cmp.setup {
  formatting = {
    format = lspkind.cmp_format(
      {
        mode = "symbol_text",
        maxwidth = 50,
        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        ---@diagnostic disable-next-line: unused-local
        before = function(entry, vim_item) return vim_item end,
      }
    ),
  },
}
