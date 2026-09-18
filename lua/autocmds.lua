local autocmd = vim.api.nvim_create_autocmd

-- Write on Save
autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end
})

-- Enable nvim-treesitter Folds
autocmd("FileType", {
    pattern = { "lua", "python", "vim", "vimdoc", "json" },
    callback = function()
        vim.treesitter.start()
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
