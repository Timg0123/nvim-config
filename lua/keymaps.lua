local keymap = vim.keymap.set
local s = { silent = true }

vim.g.mapleader = " "
keymap("n", "<space>", "<Nop>")

keymap("i", "jk", "<Esc>", s) -- Quit insert mode
keymap("n", "<leader>e", vim.diagnostic.open_float, s)
keymap("n", "<Leader>w", "<cmd>silent w<CR>", s) -- Save the current file
keymap("n", "<Leader>q", "<cmd>q<CR>", s) -- Quit Neovim
keymap("n", "<Leader>te", "<cmd>tabnew<CR>", s) -- Open a new tab
keymap("n", "<Leader>_", "<cmd>vsplit<CR>", s) -- Split the window vertically
keymap("n", "<Leader>-", "<cmd>split<CR>", s) -- Split the window horizontally
keymap("n", "<Leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>', s) -- Change directory to the current file's directory
keymap("n", "grd", "<cmd>lua vim.lsp.buf.definition()<CR>", s) -- Go to definition
-- Tabs
keymap("n", "tex", "<cmd>Texplore<CR>", s) -- Open Texplore
keymap("n", "<Leader><Tab>", "<cmd>tabnext<CR>", s) -- Next Tab
keymap("n", "<Leader><S-Tab>", "<cmd>tabnext<CR>", s) -- Next Tab
-- Ruff
keymap("n", "<Leader>fo", ":lua vim.lsp.buf.format()<CR>", s) -- Format the current buffer
keymap("n", "<Leader>ca", vim.lsp.buf.code_action)

-- Surround brackets
vim.keymap.set("x", "S", function()
    local char = vim.fn.getcharstr()

    local pairs = {
        ["["] = "]",
        ["("] = ")",
        ["{"] = "}",
        ["<"] = ">",
    }

    local closing = pairs[char]
    if not closing then
        return
    end

    local start = vim.fn.getpos("v")
    local finish = vim.fn.getpos(".")

    -- Make sure start comes before finish
    if start[2] > finish[2] or
        (start[2] == finish[2] and start[3] > finish[3]) then
        start, finish = finish, start
    end

    local row1, col1 = start[2] - 1, start[3] - 1
    local row2, col2 = finish[2] - 1, finish[3]

    vim.api.nvim_buf_set_text(0, row1, col1, row1, col1, { char })
    vim.api.nvim_buf_set_text(0, row2, col2 + 1, row2, col2 + 1, { closing })
end)

-- Development
keymap("n", "<C-e>o", "<cmd>e $MYVIMRC<CR>")
keymap("n", "<leader>r", function () -- Reload current File
    vim.cmd("silent write")
    local file = vim.fn.expand("%:p")
    local module = file:match("lua[/\\](.+)%.lua$")

    if module then
        module = module:gsub('[/\\]init$', ''):gsub('[/\\]', '.')
        package.loaded[module] = nil
        require(module)
    else
        vim.cmd('source %')
    end
end, s)

