local keymap = vim.keymap.set

vim.g.mapleader = " "
-- keymap("n", "<space>", "<Nop>")

keymap("i", "jk", "<esc>", { desc = "Escape to Normal mode" })
keymap("n", "qq", "<cmd>q<cr>", { desc = "Quit" })

-- Nvim-Tree --
keymap("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", { desc = "Toggle File-Tree" })
keymap("n", "<leader>f", "<cmd>NvimTreeFocus<cr>", { desc = "Focus File-Tree" })

-- Tab / Window Movement --
keymap("n", "<leader>L", "<cmd>tabnext<cr>", { desc = "Next Tab" })
keymap("n", "<leader>H", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
keymap("n", "<leader>h", "<C-w>h", { desc = "Focus Left Window" })
keymap("n", "<leader>l", "<C-w>l", { desc = "Focus Right Window" })
keymap("n", "<leader>k", "<C-w>k", { desc = "Focus Upper Window" })
keymap("n", "<leader>j", "<C-w>j", { desc = "Focus Lower Window" })
