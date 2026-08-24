-- Highlight Groups
local config = {
    diagnostic_symbols = {
        error = "",
        warn = "",
        -- info = "",
        hint = "",
    }
}
local color = "#ababab"
vim.api.nvim_set_hl(0, "LightGreyBold", { fg = color, bold = true })
vim.api.nvim_set_hl(0, "LightGrey", { fg = color })

vim.api.nvim_set_hl(0, "Statusline", { bg = "NONE" })
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
    return mode
end
local function get_lsp_name()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    if #clients ~= 0 then
        return " " .. clients[1].name
    else return ""
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
        " ", hl("LightGreyBold", get_mode()),
        "   ", hl("LightGrey", "%t"),
        "   ", hl("LightGrey", get_lsp_name()),
        "%=",
        get_diagnostics(), " ",
        get_fileicon(), "  ",
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

