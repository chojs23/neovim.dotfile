local smart_splits = require("smart-splits")
smart_splits.setup({})

local map = vim.keymap.set

map("n", "<C-h>", smart_splits.move_cursor_left, { desc = "Move cursor left" })
map("n", "<C-j>", smart_splits.move_cursor_down, { desc = "Move cursor down" })
map("n", "<C-k>", smart_splits.move_cursor_up, { desc = "Move cursor up" })
map("n", "<C-l>", smart_splits.move_cursor_right, { desc = "Move cursor right" })
map("n", "<A-h>", smart_splits.resize_left, { desc = "Resize left" })
map("n", "<A-j>", smart_splits.resize_down, { desc = "Resize down" })
map("n", "<A-k>", smart_splits.resize_up, { desc = "Resize up" })
map("n", "<A-l>", smart_splits.resize_right, { desc = "Resize right" })
