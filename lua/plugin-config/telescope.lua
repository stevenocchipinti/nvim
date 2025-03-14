local actions = require("telescope.actions")
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local action_state = require('telescope.actions.state')

local trouble = require("trouble.sources.telescope")

require("telescope").setup {
    defaults = {
        winblend = 5,
        selection_caret = "󰁔 ",
        prompt_prefix = " ",
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_better,
                ["<C-k>"] = actions.move_selection_worse,
                ["<c-t>"] = trouble.open
            },
            n = {["<c-t>"] = trouble.open}
        }
    }
}

vim.keymap.set("n", "<leader>T", "<cmd>Telescope<cr>")
vim.keymap.set("n", "<leader>tt", "<cmd>TelescopeTypescriptTools<cr>")
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
vim.keymap.set("n", "<leader>.", function()
    require("telescope.builtin").find_files({search_dirs = {"~/.config/nvim"}})
end)

-- Below is a custom telescope command for all the ts-tools commands

-- Function to fetch commands that start with 'TSTools'
local function get_tstools_commands()
    local tstools_commands = {}
    for command, _ in pairs(vim.api.nvim_get_commands({})) do
        if command:match("^TSTools") then
            table.insert(tstools_commands, command)
        end
    end
    return tstools_commands
end

-- Custom Telescope picker to display TSTools commands
local function telescope_typescript_tools_picker()
    local tstools_commands = get_tstools_commands()

    pickers.new({}, {
        prompt_title = 'TSTools Commands',
        finder = finders.new_table {results = tstools_commands},
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                -- Execute the selected command
                vim.cmd(selection[1])
            end)
            return true
        end
    }):find()
end

-- Register the custom Telescope command
vim.api.nvim_create_user_command('TelescopeTypescriptTools',
                                 telescope_typescript_tools_picker, {})
