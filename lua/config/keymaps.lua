vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<F1>", "")

-- if using copilot.vim
-- vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)")
-- vim.keymap.set("i", "<C-p>", "<Plug>(copilot-previous)")
-- vim.api.nvim_set_keymap("i", "<C-CR>", 'copilot#Accept(" < CR > ")', { expr = true, silent = true })
