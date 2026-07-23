local smart_splits = require("smart-splits")
smart_splits.setup({})

local map = vim.keymap.set

local function resize_and_remember_tree_width(resize)
  return function()
    resize()

    local api = require("nvim-tree.api")
    local winid = api.tree.winid()
    if not winid then
      return
    end

    for _, other_winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local is_tiled_neighbor = other_winid ~= winid
        and vim.api.nvim_win_get_config(other_winid).relative == ""
      if is_tiled_neighbor then
        api.tree.resize({ absolute = vim.api.nvim_win_get_width(winid) })
        return
      end
    end
  end
end

map("n", "<C-h>", smart_splits.move_cursor_left, { desc = "Move cursor left" })
map("n", "<C-j>", smart_splits.move_cursor_down, { desc = "Move cursor down" })
map("n", "<C-k>", smart_splits.move_cursor_up, { desc = "Move cursor up" })
map("n", "<C-l>", smart_splits.move_cursor_right, { desc = "Move cursor right" })
map("n", "<A-h>", resize_and_remember_tree_width(smart_splits.resize_left), { desc = "Resize left" })
map("n", "<A-j>", smart_splits.resize_down, { desc = "Resize down" })
map("n", "<A-k>", smart_splits.resize_up, { desc = "Resize up" })
map("n", "<A-l>", resize_and_remember_tree_width(smart_splits.resize_right), { desc = "Resize right" })
