local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<F1>", "")
vim.keymap.set("i", "<F1>", "")

vim.keymap.set("i", "<ESC>", "<ESC>l")

-- NeoTree postion current
vim.keymap.set("n", "<leader>n", ":Neotree position=current<CR>", { silent = true })

-- Resize window using <ctrl> arrow keys
-- map("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- map("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- map("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
-- map("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- if using copilot.vim
-- vim.keymap.set("i", "<C-n>", "<Plug>(copilot-next)")
-- vim.keymap.set("i", "<C-p>", "<Plug>(copilot-previous)")
-- vim.api.nvim_set_keymap("i", "<C-CR>", 'copilot#Accept(" < CR > ")', { expr = true, silent = true })
