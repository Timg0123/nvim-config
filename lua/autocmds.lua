local autocmd = vim.api.nvim_create_autocmd

-- Write on Save
autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end
})
