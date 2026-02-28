require "nvchad.mappings"

local map = vim.keymap.set

-- Save
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "save file" })

-- Undo/redo
map("n", "<C-z>", "u", { desc = "undo" })
map("n", "<C-y>", "<C-r>", { desc = "redo" })

-- Move lines with Alt+j/k
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })
