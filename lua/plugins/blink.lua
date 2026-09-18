local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
    signature = { enabled = true },
    keymap = {
        ['<Tab>'] = {
            function(cmp)
                if cmp.snippet_active() then
                    return cmp.accept()
                else
                    return cmp.select_and_accept()
                end
            end,
            'snippet_forward',
            'fallback'
        },
        ["<Esc>"] = { "cancel", "fallback" },

        ["<C-j>"] = { "select_next" },
        ["<C-k>"] = { "select_prev", "fallback" },

        ["<C-l>"] = { "show_signature", "hide_signature", "fallback" },
    },
})
