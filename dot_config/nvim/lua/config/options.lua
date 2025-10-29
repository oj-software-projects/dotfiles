-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Treat template files ending in .lua.tmpl as Lua so LSP and completion work.
vim.filetype.add({
  pattern = {
    [".*%.lua%.tmpl"] = "lua",
  },
})
