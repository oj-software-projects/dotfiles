-- lua/utils/colors.lua
local M = {}

-- Liste der verfügbaren Themes (muss dem "colorscheme"-Namen entsprechen)
M.themes = {
  "everforest", -- sainnhe/everforest
  "tokyonight", -- folke/tokyonight.nvim
  "catppuccin", -- catppuccin/nvim
  "gruvbox-material", -- sainnhe/gruvbox-material
  "kanagawa", -- rebelot/kanagawa.nvim
  "sonokai", -- sainnhe/sonokai
  "tokyodark", -- tiagovla/tokyodark.nvim
  "nightfox", -- EdenEast/nightfox.nvim
  "OceanicNext", -- mhartington/oceanic-next (Colorscheme-Name: 'OceanicNext')
  "dracula", -- Mofiqul/dracula.nvim
  "nord", -- shaunsingh/nord.nvim
  "rose-pine", -- rose-pine/neovim
  "tokyonight",
}

-- Pfad zur Cache-Datei für das zuletzt verwendete Theme
local cache_file = vim.fn.stdpath("cache") .. "/last_theme"

-- Hilfsfunktion: Index eines Wertes in einer Liste
local function index_of(tbl, val)
  for i, v in ipairs(tbl) do
    if v == val then
      return i
    end
  end
  return nil
end

-- Liest den Index des zuletzt verwendeten Themes
local function read_last_index()
  local f = io.open(cache_file, "r")
  if not f then
    return 1
  end
  local last = f:read("*l")
  f:close()
  local idx = index_of(M.themes, last)
  return idx or 1
end

-- Speichert das zuletzt verwendete Theme
local function write_last(theme)
  local f = io.open(cache_file, "w")
  if f then
    f:write(theme)
    f:close()
  end
end

-- Aktueller Index (aus Cache oder Standard)
M.idx = read_last_index()

-- Setzt ein Theme anhand des Namens
function M.apply(theme)
  -- Theme-spezifische Einstellungen
  if theme == "nord" then
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_disable_background = true
    vim.g.nord_italic = false
    vim.g.nord_uniform_diff_background = true
    vim.g.nord_bold = false
  elseif theme == "catppuccin" then
    require("catppuccin").setup({ flavour = "mocha", transparent_background = true })
  elseif theme == "rose-pine" then
    require("rose-pine").setup({ dark_variant = "moon", disable_background = true })
  elseif theme == "tokyonight" then
    require("tokyonight").setup({ style = "storm", transparent = true })
  elseif theme == "kanagawa" then
    require("kanagawa").setup({ undercurl = true, commentStyle = { italic = true } })
  end

  -- Colorscheme anwenden und Cache aktualisieren
  vim.cmd("colorscheme " .. theme)
  write_last(theme)
  local idx = index_of(M.themes, theme)
  M.idx = idx or M.idx
end

-- Gibt den Namen des aktuellen Themes zurück
function M.current()
  return M.themes[M.idx]
end

-- Zyklisches Umschalten der Themes
function M.cycle()
  M.idx = (M.idx % #M.themes) + 1
  M.apply(M.themes[M.idx])
end

-- User-Command zum Anzeigen des aktuellen Themes
vim.cmd([[
  command! CurrentTheme lua print('Aktuelles Theme: ' .. require('utils.colors').current())
]])

-- Keymap zum Umschalten
vim.keymap.set("n", "<leader>ct", M.cycle, { desc = "Cycle color scheme", noremap = true, silent = true })

-- Beim Start das gespeicherte oder erste Theme setzen
M.apply(M.themes[M.idx])

return M
