local luasnip = require("luasnip")
local snip = luasnip.snippet
-- local sn = luasnip.snippet_node
-- local isn = luasnip.indent_snippet_node
-- local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node
-- local c = luasnip.choice_node
-- local d = luasnip.dynamic_node
-- local r = luasnip.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
-- local m = require("luasnip.extras").m
-- local lambda = require("luasnip.extras").l
-- local postfix = require("luasnip.extras.postfix").postfix

luasnip.config.set_config {
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = true,

    -- This one is cool cause if you have dynamic snippets, it updates as you type!
    updateevents = "TextChanged,TextChangedI",

    -- This might be useful for when stopping using a snippet halfway
    delete_check_events = "TextChanged,InsertLeave",

    -- Autosnippets:
    enable_autosnippets = true

    -- ext_opts = {
    --   [types.choiceNode] = {
    --     active = { virt_text = { { " <- Current Choice", "NonTest" } } },
    --   },
    -- },
}

require("luasnip.loaders.from_vscode").lazy_load()

vim.keymap.set({"i", "s"}, "<c-j>", function()
    if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end
end, {silent = true})

vim.keymap.set({"i", "s"}, "<c-k>", function()
    if luasnip.jumpable(-1) then luasnip.jump(-1) end
end, {silent = true})

vim.keymap.set("i", "<c-l>", function()
    if luasnip.choice_active() then luasnip.change_choice(1) end
end)

-- The snippets

luasnip.add_snippets("javascript", {
    snip({trig = "import", name = "import named"},
         fmt([[import {{ {} }} from "{}"]], {i(2), i(1)})),

    snip({trig = "import", name = "import default"},
         fmt([[import {} from "{}"]], {i(1), i(2)})),

    snip({trig = "useState", name = "React useState"},
         fmt([[const [{}] = useState({})]], {
        f(function(args)
            return args[1][1] .. ", " .. "set" ..
                       args[1][1]:gsub("^%l", string.upper)
        end, {1}), i(1)
    })), snip({trig = "useEffect", name = "React useEffect"},
              fmt([[useEffect(() => {{
  {}
}}, [{}])
]], {i(1), i(2)}))
})

luasnip.filetype_extend("javascript",
                        {"javascriptreact", "typescript", "typescriptreact"})
luasnip.filetype_extend("javascriptreact",
                        {"javascript", "typescript", "typescriptreact"})
luasnip.filetype_extend("typescript",
                        {"javascriptreact", "javascript", "typescriptreact"})
luasnip.filetype_extend("typescriptreact",
                        {"javascriptreact", "typescript", "javascript"})
