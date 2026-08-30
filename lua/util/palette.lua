local M = {}

local cache = nil

local function load_palette()
  if vim.g.colors_name ~= "kanagawa" then
    return nil
  end
  local ok, colors = pcall(function()
    return require("kanagawa.colors").setup()
  end)
  return (ok and colors.palette) or nil
end

-- Recompute only when the colorscheme actually changes
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function() cache = load_palette() end,
})
cache = load_palette() -- populate once for the initial scheme

---@param name string    color key in kanagawa's palette, e.g. "autumnYellow"
---@param default string hex fallback used if kanagawa isn't active or the key is missing
function M.get(name, default)
  return (cache and cache[name]) or default
end

return M
