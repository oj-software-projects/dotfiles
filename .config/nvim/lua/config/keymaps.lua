-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
vim.keymap.set("n", "L", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "H", ":bprev<CR>", { noremap = true, silent = true })

-- Escape mappings (wie in .ideavimrc)
vim.keymap.set("i", "jj", "<ESC>", { noremap = true, silent = true })
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })

-- im Normal-Mode <leader>mf → nur Funktionen/Methoden im aktuellen File per fzf-lua
vim.keymap.set("n", "<leader>mf", function()
  require("fzf-lua").lsp_document_symbols({
    symbols = { "Function", "Method" },
  })
end, { noremap = true, silent = true, desc = "fzf-lua: show only funcs/methods" })

-- Verschiebe Zeilen nach unten/oben im visuellen Modus
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Custom Yank / Delete / Format Mappings (aus .ideavimrc)
vim.keymap.set("n", "<leader>ya", "ggVGy", { noremap = true, silent = true, desc = "Yank all" })
vim.keymap.set("n", "<leader>yp", 'vap"+y', { noremap = true, silent = true, desc = "Yank paragraph/block" })
vim.keymap.set("n", "<leader>yf", "[{V%y", { noremap = true, silent = true, desc = "Yank function" })
vim.keymap.set("n", "<leader>df", "[{V%d", { noremap = true, silent = true, desc = "Delete function" })
vim.keymap.set("n", "<leader>=", "[{V%gq", { noremap = true, silent = true, desc = "Format function" })

-- Window Splits (wie in .ideavimrc)
vim.keymap.set("n", "<leader>wh", ":split<CR>", { noremap = true, silent = true, desc = "Split Horizontal" })
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>", { noremap = true, silent = true, desc = "Split Vertical" })
vim.keymap.set("n", "<leader>\\", ":vsplit<CR>", { noremap = true, silent = true, desc = "Split Vertical" })
vim.keymap.set("n", "<leader>ww", "<C-w>o", { noremap = true, silent = true, desc = "Close other windows (Unsplit)" })

vim.g.VM_maps = {
  ["Find Under"] = "gb",
}
--some test for chezmoi
