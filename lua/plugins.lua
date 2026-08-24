vim.pack.add({
    -- theme
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
    -- syntax highliting
    { src = "nvim-treesitter/nvim-treesitter" },
    -- autocompletion
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/xzbdmw/colorful-menu.nvim" },
    { src = "https://github.com/nvim-mini/mini.icons" },
    -- autopairs
    { src = "'https://github.com/nvim-mini/mini.pairs" },
})


require("mini.pairs").setup()
require("gruvbox").setup()
require('nvim-treesitter').install { "python" }
require("mini.icons").setup({
    lsp = {
        ["function"] = { glyph = "󰊕" },
    },
})

local function get_mini_icon(ctx)
	if ctx.source_name == "Path" then
		local is_unknown_type = vim.tbl_contains(
				{ "link", "socket", "fifo", "char", "block", "unknown" },
				ctx.item.data.type
		)
		local mini_icon, mini_hl, _ = require("mini.icons").get(
				is_unknown_type and "os" or ctx.item.data.type,
				is_unknown_type and "" or ctx.label
		)
		if mini_icon then
				return mini_icon, mini_hl
		end
	end
	local mini_icon, mini_hl, _ = require("mini.icons").get("lsp", ctx.kind)
	return mini_icon, mini_hl
end
require("blink.cmp").setup({
	fuzzy = { implementation = "prefer_rust_with_warning" },
	signature = { enabled = true },
	keymap = {
		preset = "default",
		["<C-p>"] = {},
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<C-l>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-n>"] = { "select_and_accept" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-b>"] = { "scroll_documentation_down", "fallback" },
		["<C-f>"] = { "scroll_documentation_up", "fallback" },
		["<C-h>"] = { "snippet_forward", "fallback" },
		["<C-S-h>"] = { "snippet_backward", "fallback" },
		-- ["<C-e>"] = { "hide" },
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "normal",
	},

	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		menu = {
			draw = {
				components = {
					label = {
						text = require("colorful-menu").blink_components_text,
						highlight = require("colorful-menu").blink_components_highlight,
					},
					kind_icon = {
                        text = function (ctx)
                            local kind_icon, _ = get_mini_icon(ctx)
                            return kind_icon
                        end,

                        highlight = function (ctx)
                            local _, kind_hl = get_mini_icon(ctx)
                            return kind_hl
                        end,
					},
                    kind = {
                        highlight = function (ctx)
                            local _, kind_hl = get_mini_icon(ctx)
                            return kind_hl
                        end,
                    },
				},
				columns = {
					{ "label" },
					{ "kind_icon" },
					{ "kind" },
				},
			},
		},
		ghost_text = {
			enabled = true,
			show_with_menu = true,
		},
	},

	cmdline = {
		keymap = {
			preset = "inherit",
		},
		completion = {
            menu = { auto_show = true },
        },
	},

	sources = { default = { "lsp" } },
})

