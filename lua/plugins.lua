vim.pack.add({
    -- Themes / Highlight --
    "https://github.com/olimorris/onedarkpro.nvim",
    "https://github.com/sainnhe/gruvbox-material",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/lukas-reineke/indent-blankline.nvim",


    -- LSP --
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",


    -- UI / Completion --
    "https://github.com/saghen/blink.lib",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/nvim-mini/mini.pairs",

    "https://github.com/folke/noice.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/rcarriga/nvim-notify",

    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/nvim-lualine/lualine.nvim",

})

require("plugins.noice")
require("plugins.nvim-treesitter")
require("plugins.blink")
require("mini.pairs").setup()
require("ibl").setup()
require("plugins.nvim-tree")
require("plugins.lualine")
