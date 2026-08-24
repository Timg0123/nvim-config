local keymap = vim.keymap.set
local s = { silent = true }

vim.g.mapleader = " "
keymap("n", "<space>", "<Nop>")

keymap("i", "jk", "<Esc>", s) -- Quit insert mode
keymap("n", "<leader>e", vim.diagnostic.open_float, s)
keymap("n", "<Leader>w", "<cmd>w<CR>", s) -- Save the current file
keymap("n", "<Leader>q", "<cmd>q<CR>", s) -- Quit Neovim
keymap("n", "<Leader>te", "<cmd>tabnew<CR>", s) -- Open a new tab
keymap("n", "<Leader>_", "<cmd>vsplit<CR>", s) -- Split the window vertically
keymap("n", "<Leader>-", "<cmd>split<CR>", s) -- Split the window horizontally
keymap("n", "<Leader>fo", ":lua vim.lsp.buf.format()<CR>", s) -- Format the current buffer using LSP
keymap("n", "<Leader>cd", '<cmd>lua vim.fn.chdir(vim.fn.expand("%:p:h"))<CR>', s) -- Change directory to the current file's directory
keymap("n", "grd", "<cmd>lua vim.lsp.buf.definition()<CR>", s) -- Go to definition
-- Tabs
keymap("n", "tex", "<cmd>Texplore<CR>", s) -- Open Texplore
keymap("n", "<Leader><Tab>", "<cmd>tabnext<CR>", s) -- Next Tab
keymap("n", "<Leader><S-Tab>", "<cmd>tabnext<CR>", s) -- Next Tab

-- Development
keymap("n", "<leader>r", function () -- Reload current File
    vim.cmd.write()
    local file = vim.fn.expand("%:p")
    local module = file:match("lua[/\\](.+)%.lua$")

    if module then
        module = module:gsub('[/\\]init$', ''):gsub('[/\\]', '.')
        package.loaded[module] = nil
        require(module)
        -- print('Reloaded module: ' .. module)
    else
        vim.cmd('source %')
        -- print('Sourced: ' .. file)
    end
end, s)

