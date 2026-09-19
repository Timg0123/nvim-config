require("mason").setup()
require("mason-lspconfig").setup { -- list :help lspconfig-all
    ensure_installed = {
        "lua_ls",
        "pyright",
        "jdtls"
    },

    automatic_enable = true,
}

-- Additional LSP Configurations to add to "nvim-lspconfig"
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
                library = { vim.env.VIMRUNTIME },
            },
            diagnostics = {
                globals = { "vim", "hl" },
            }
        }
    }
})
