-- Highlight Groups
local config = {
    diagnostic_symbols = {
        error = "",
        warn = "",
        -- info = "",
        hint = "",
    }
}
local nvim_set_hl = vim.api.nvim_set_hl
local nvim_get_hl = vim.api.nvim_get_hl

-- Get Default Colors
local p_menu = nvim_get_hl(0, { name = "Pmenu" })
local diagnostic_warn = nvim_get_hl(0, { name = "DiagnosticWarn"})
local normal = nvim_get_hl(0, { name = "Normal" })

nvim_set_hl(0, "LightGreyBold", { fg = normal.fg, bold = true })
nvim_set_hl(0, "LightGrey", { fg = normal.fg })
nvim_set_hl(0, "YellowBorder", { fg = diagnostic_warn.fg })
nvim_set_hl(0, "Statusline", { bg = p_menu.bg })
-- Modes
nvim_set_hl(0, "NormalMode", { fg = "#D27E99" })
nvim_set_hl(0, "InsertMode", { fg = "#76946A" })
nvim_set_hl(0, "VisualMode", { fg = "#7E9CD8" })
nvim_set_hl(0, "CommandMode", { fg = "#957FB8" })


local function hl(group, text)
    return string.format("%%#%s#%s%%*", group, text)
end

-- Items for Statusline
local function get_fileicon()
    local extension = vim.bo.filetype
    local mini_icon, mini_hl, _ = require("mini.icons").get("filetype", extension)
    return hl(mini_hl, mini_icon)
end
local function get_mode()
    local modes = {
        n = "NORMAL",
        i = "INSERT",
        v = "VISUAL",
        V = "V-LINE",
        ["\22"] = "V-BLOCK",
        c = "COMMAND",
        R = "REPLACE",
        t = "TERMINAL",
    }
    local mode = modes[vim.fn.mode()] or vim.fn.mode()
    if mode == "NORMAL" then
        return hl("NormalMode", mode)
    elseif mode == "INSERT" then
        return hl("InsertMode", mode)
    elseif mode == "VISUAL" or mode == "V-LINE" or mode == "V-BLOCK" then
        return hl("VisualMode", mode)
    elseif mode == "COMMAND" or mode == "TERMINAL" then
        return hl("CommandMode", mode)
    end
end
local function get_lsp_name()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    if #clients ~= 0 then
        return " " .. clients[1].name
    else
        return ""
    end
end
local function get_diagnostics()
    local counts = vim.diagnostic.count(0)
    local result = {}

    local diagnostics = {
        { vim.diagnostic.severity.ERROR, config.diagnostic_symbols.error, "DiagnosticError" },
        { vim.diagnostic.severity.WARN,  config.diagnostic_symbols.warn,  "DiagnosticWarn" },
        -- { vim.diagnostic.severity.INFO,  config.diagnostic_symbols.info,  "DiagnosticInfo" },
        { vim.diagnostic.severity.HINT,  config.diagnostic_symbols.hint,  "DiagnosticHint" },
    }

    for _, diagnostic in ipairs(diagnostics) do
        local count = counts[diagnostic[1]] or 0

        if count > 0 then
            table.insert(
                result,
                "%#" .. diagnostic[3] .. "#" .. diagnostic[2] .. count .. "%*"
            )
        end
    end

    return table.concat(result, " ")
end

-- Statusline
Statusline = {}
function Statusline.active()
    return table.concat {
        hl("YellowBorder", "▊"),
        " ", hl("sakuraPink", get_mode()),
        "   ", hl("LightGrey", get_lsp_name()),
        "   ", hl("LightGrey", "%t"),
        " ", hl("LightGrey", "%m"),
        "%=",
        get_diagnostics(), " ",
        get_fileicon(), "  ",
        hl("YellowBorder", "▊"),
    }
end

function Statusline.inactive()
    return " %t"
end

local group
vim.api.nvim_create_augroup("Statusline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = group,
    desc = "Activate statusline on focus",
    callback = function()
        vim.opt_local.statusline = "%!v:lua.Statusline.active()"
    end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = group,
    desc = "Deactivate statusline when unfocused",
    callback = function()
        vim.opt_local.statusline = "%!v:lua.Statusline.inactive()"
    end,
})

