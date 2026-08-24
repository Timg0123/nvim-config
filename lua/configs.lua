local opt = vim.opt
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.expandtab = true
-- opt.listchars = "tab: ,multispace:|"
-- opt.list = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.wrap = false
opt.cursorline = true
opt.scrolloff = 8
opt.completeopt = { "menuone", "popup", "noinsert" }
opt.winborder = "rounded"
opt.hlsearch = false
opt.clipboard:append("unnamedplus")

vim.cmd.colorscheme("gruvbox")
vim.cmd.filetype("plugin indent on")

