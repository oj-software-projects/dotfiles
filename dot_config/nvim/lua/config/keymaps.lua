-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
vim.keymap.set("n", "L", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "H", ":bprev<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true })
-- im Normal-Mode <leader>gm → nur Funktionen/Methoden im aktuellen File per fzf-lua
vim.keymap.set("n", "<leader>gm", function()
  require("fzf-lua").lsp_document_symbols({
    symbols = { "Function", "Method" },
  })
end, { noremap = true, silent = true, desc = "fzf-lua: show only funcs/methods" })
-- Verschiebe Zeilen nach unten im visuellen Modus
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
-- Verschiebe Zeilen nach oben im visuellen Modus
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.g.VM_maps = {
  ["Find Under"] = "gb",
}
