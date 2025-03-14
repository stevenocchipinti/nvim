-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = {noremap = true, silent = true}
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local keymap_on_attach = function(_, bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<leader>q",
                   function() vim.lsp.buf.format({async = true}) end, bufopts)
    vim.keymap.set("n", "<leader>rn", ":IncRename ")
end

-- Requires neovim 0.8:
--   https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local format_on_save_on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    -- apply whatever logic you want (in this example, we'll only use null-ls)
                    filter = function(c)
                        return c.name == "null-ls"
                    end,
                    bufnr = bufnr
                })
            end
        })
    end
end

require("inc_rename").setup {input_buffer_type = "dressing"}

-- Mason (previously lspinstall)
-- Installs the nessesary binaries for LSP to work (tsserver, etc.)

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {},
  automatic_installation = true
}

-- Special non-LSP typescript tools config
-- Hopefully one day this will be replaced with a proper LSP version
require("typescript-tools").setup {
  settings = {
    tsserver_plugins = {
      -- for TypeScript v4.9+
      "@styled/typescript-styled-plugin",
      -- or for older TypeScript versions
      -- "typescript-styled-plugin",
    },
  },
}

-- LSP config

local lspconfig = require "lspconfig"
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.rust_analyzer.setup {
    on_attach = keymap_on_attach,
    capabilities = capabilities,
    cmd = {"rustup", "run", "stable", "rust-analyzer"}
}

lspconfig.lua_ls.setup {
    server = function(client, bufnr) keymap_on_attach(client, bufnr) end,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT"
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {"vim"}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    }
}

require'lspconfig'.pylsp.setup {
    settings = {
        pylsp = {
            plugins = {pycodestyle = {ignore = {'W391'}, maxLineLength = 80}}
        }
    }
}

capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.html.setup {capabilities = capabilities, on_attach = keymap_on_attach}

lspconfig.cssls.setup {
    capabilities = capabilities,
    on_attach = keymap_on_attach
}

lspconfig.bashls.setup {on_attach = keymap_on_attach}

lspconfig.emmet_ls.setup({
    on_attach = keymap_on_attach,
    capabilities = capabilities,
    filetypes = {
        "html", "typescriptreact", "javascriptreact", "css", "sass", "scss",
        "less"
    }
})

lspconfig.astro.setup {}

-- Null-ls configs (non language server integrations)

local null_ls = require "null-ls"
null_ls.setup {
    sources = {
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.formatting.xmllint,
        null_ls.builtins.formatting.lua_format,
        null_ls.builtins.formatting.rustfmt,

        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.fish, null_ls.builtins.diagnostics.zsh,

        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.code_actions.gitsigns,

        null_ls.builtins.hover.dictionary
    },
    on_attach = function(client, bufnr)
        keymap_on_attach(client, bufnr)
        format_on_save_on_attach(client, bufnr)
    end
}

-- Custom diagnostic icons

local signs = {Error = " ", Warn = " ", Hint = " ", Info = " "}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end
