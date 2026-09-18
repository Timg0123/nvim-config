require("nvim-treesitter").setup()
require("nvim-treesitter").install { "python", "lua", "vim", "vimdoc", "json" }

vim.api.nvim_create_autocmd('FileType', {
    pattern = { '<filetype>' },
    callback = function()
        vim.treesitter.start()
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
    end,
})
