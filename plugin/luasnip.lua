local luasnip = require("luasnip")

luasnip.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  -- updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

  -- ext_opts = {
  --   [types.choiceNode] = {
  --     active = { virt_text = { { " <- Current Choice", "NonTest" } } },
  --   },
  -- },
}

vim.keymap.set(
  { "i", "s" }, "<c-j>", function()
    if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end
  end, { silent = true }
)

vim.keymap.set(
  { "i", "s" }, "<c-k>",
    function() if luasnip.jumpable(-1) then luasnip.jump(-1) end end,
    { silent = true }
)

vim.keymap.set(
  "i", "<c-l>",
    function() if luasnip.choice_active() then luasnip.change_choice(1) end end
)
