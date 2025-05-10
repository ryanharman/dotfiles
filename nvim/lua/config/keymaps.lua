local keymap = vim.keymap.set
local silent = { silent = true }

-- Enable mouse
vim.opt.mouse = "a"

-- General
-- Clear highlights on search with <leader>h
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Save file
keymap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Window navigation
-- Use CTRL+<hjkl> to move between splits
keymap("n", "<C-h>", "<C-w><C-h>", { desc = "Move to left split" })
keymap("n", "<C-l>", "<C-w><C-l>", { desc = "Move to right split" })
keymap("n", "<C-j>", "<C-w><C-j>", { desc = "Move to lower split" })
keymap("n", "<C-k>", "<C-w><C-k>", { desc = "Move to upper split" })

-- Clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard", silent = true })
keymap("n", "<leader>p", '"+p', { desc = "Paste from system clipboard", silent = true })

-- Delete without yanking
keymap("n", "x", '"_x', silent)
keymap("n", "X", '"_X', silent)
keymap("v", "x", '"_x', silent)
keymap("v", "X", '"_X', silent)

-- Diagnostics
keymap("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show diagnostics", silent = true })
