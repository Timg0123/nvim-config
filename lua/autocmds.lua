local autocmd = vim.api.nvim_create_autocmd

-- Format on Save
autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local clients = vim.lsp.get_clients({
            bufnr = 0,
            method = "textDocument/formatting",
        })
        if #clients < 0 then
            vim.lsp.buf.format({ async = false })
        end
    end,
})
