local statuscolumn = {};

statuscolumn.sign = function()
    local lnum = vim.v.lnum
    local diags = vim.diagnostic.get(0, { lnum = lnum - 1 })
    if #diags == 0 then return " " end
    table.sort(diags, function(a, b) return a.severity < b.severity end)
    local icons = { "E", "W", "I", "H" }
    local hl = { "DiagnosticSignError", "DiagnosticSignWarn", "DiagnosticSignInfo", "DiagnosticSignHint" }
    local sev = diags[1].severity
    return "%#" .. hl[sev] .. "#" .. icons[sev] .. "%*"
end
statuscolumn.number = function(user_config)
    local text = "";

    local config = vim.tbl_extend("keep", user_config or {}, { mode = "normal" })

    if config.mode == "normal" then
        text = text .. vim.v.lnum;
    elseif config.mode == "relative" then
        text = text .. vim.v.relnum;
    end

    return "%#LineNr#" .. text;
end
statuscolumn.border = function()
    return "%#LineNr#│";
end
statuscolumn.myStatuscolumn = function()
    local text = "";

    text = table.concat({
        statuscolumn.sign(),
        statuscolumn.border(),
        statuscolumn.number({ mode = "relative" }),
    })

    return text;
end
vim.o.statuscolumn = "%!v:lua.require('statuscolumn').myStatuscolumn()";

return statuscolumn;
