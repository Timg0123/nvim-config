local keymap = vim.keymap.set

vim.g.mapleader = " "
-- keymap("n", "<space>", "<Nop>")

keymap("i", "jk", "<esc>", { desc = "Escape to Normal mode" })
keymap("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
keymap("n", "<leader>w", "<cmd>write<cr>", { desc = "Write Buffer" })


-- Nvim-Tree --
keymap("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", { desc = "Toggle File-Tree" })
keymap("n", "<leader>f", "<cmd>NvimTreeFocus<cr>", { desc = "Focus File-Tree" })


-- Tab / Window Movement --
--normal mode
keymap("n", "<A-l>", "<C-w>l", { desc = "Focus right Window" })
keymap("n", "<A-h>", "<C-w>h", { desc = "Focus left Window" })
keymap("n", "<A-k>", "<C-w>k", { desc = "Focus upper Window" })
keymap("n", "<A-j>", "<C-w>j", { desc = "Focus lower Window" })
keymap("n", "<A-L>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
keymap("n", "<A-H>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
--terminal mode
keymap("t", "<A-l>", "<C-\\><C-n><C-w>l", { desc = "Exit terminal and focus right Window" })
keymap("t", "<A-h>", "<C-\\><C-n><C-w>h", { desc = "Exit terminal and focus left Window" })
keymap("t", "<A-k>", "<C-\\><C-n><C-w>k", { desc = "Exit terminal and focus upper Window" })
keymap("t", "<A-j>", "<C-\\><C-n><C-w>j", { desc = "Exit terminal and focus lower Window" })
keymap("t", "<A-L>", "<C-\\><C-n><cmd>tabnext<cr>", { desc = "Next Tab" })
keymap("t", "<A-H>", "<C-\\><C-n><cmd>tabprevious<cr>", { desc = "Previous Tab" })


-- LSP diagnostics --
keymap("n", "<leader>d", function() vim.diagnostic.open_float() end, { desc = "Open Diagnostics Float" })


-- Terminal --
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal mode" })
keymap("t", "jk", "<C-\\><C-n>", { desc = "Exit Terminal mode" })
local is_windows = vim.fn.has "win32" ~= 0
local shell = is_windows and "pwsh" or "bash"
keymap("n", "<leader>T", "<cmd>tabnew | terminal" .. shell .. "<cr>i", { desc = "Open Terminal in new Tab" })
keymap("n", "<leader>t", "<cmd>split term://".. shell .. "<cr>i", { desc = "Open Terminal in horizontal split" })
