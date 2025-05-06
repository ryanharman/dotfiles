local keymap = vim.keymap.set
local silent = { silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.mouse = "a"

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
keymap("n", "<leader>h", ":nohlsearch<CR>")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keymap("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

keymap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- formatting
keymap({ "n", "v" }, "<leader>cf", function()
	LazyVim.format({ force = true })
end, { desc = "Format" })

-- Don't yank on delete char
keymap("n", "x", '"_x', silent)
keymap("n", "X", '"_X', silent)
keymap("v", "x", '"_x', silent)
keymap("v", "X", '"_X', silent)

-- Show diagnostics
keymap("n", "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<CR>", silent)

-- Copy to system clipboard
keymap("n", "<leader>y", '"+y', silent)
-- Paste from system clipboard
keymap("n", "<leader>p", '"+p', silent)
