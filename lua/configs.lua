local opt = vim.opt
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.expandtab = true
opt.wrap = false
opt.cursorline = true
opt.scrolloff = 8
opt.completeopt = { "menuone", "popup", "noinsert" }
opt.winborder = "rounded"
opt.hlsearch = false
opt.clipboard:append("unnamedplus")
opt.showmode = false
opt.signcolumn = "yes"

-- line-numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 8
_G.centered_lnum = function()
  local width = math.max(2, #tostring(vim.fn.line("$")))
  local lnum = vim.v.relnum == 0 and vim.v.lnum or vim.v.relnum
  local str = tostring(lnum)
  return string.rep(" ", width - #str) .. str
end
vim.opt.statuscolumn = "%s%=%{v:lua.centered_lnum()}%=   "


vim.cmd.filetype("plugin indent on")


