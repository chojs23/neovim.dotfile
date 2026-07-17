local api = require("nvim-tree.api")

-- Shows "rw-r--r-- 1.2K" right-aligned for each file
local stats_min_width = 38

local StatDecorator = api.Decorator:extend()

function StatDecorator:new()
  self.enabled = true
  self.highlight_range = "none"
  self.icon_placement = "right_align"

  -- :new() runs once per render, so the width check happens here instead
  -- of per node.
  local winid = api.tree.winid()
  self.enabled = winid ~= nil and vim.api.nvim_win_get_width(winid) >= stats_min_width
end

local function human_size(size)
  if size < 1024 then
    return size .. "B"
  end
  local units = { "K", "M", "G", "T" }
  local i = 0
  repeat
    size = size / 1024
    i = i + 1
  until size < 1024 or i == #units
  return string.format("%.1f%s", size, units[i])
end

local function rwx(mode)
  local chars = { "r", "w", "x" }
  local out = {}
  for shift = 8, 0, -1 do
    local on = math.floor(mode / 2 ^ shift) % 2 == 1
    out[#out + 1] = on and chars[(8 - shift) % 3 + 1] or "-"
  end
  return table.concat(out)
end

function StatDecorator:icons(node)
  if node.type ~= "file" then
    return nil
  end
  local stat = vim.uv.fs_stat(node.absolute_path)
  if not stat then
    return nil
  end
  return {
    { str = rwx(stat.mode) .. " " .. human_size(stat.size), hl = { "Comment" } },
  }
end

-- The decorator only runs on render, so redraw the tree when its window
-- is resized to show or hide the stats immediately.
vim.api.nvim_create_autocmd("WinResized", {
  group = vim.api.nvim_create_augroup("nvim_tree_stats_resize", { clear = true }),
  callback = function()
    local winid = api.tree.winid()
    if winid and vim.tbl_contains(vim.v.event.windows or {}, winid) then
      api.tree.reload()
    end
  end,
})

require("nvim-tree").setup({
  view = {
    width = 25,
  },
  renderer = {
    special_files = {},
    group_empty = true,
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
    decorators = {
      "Git",
      "Open",
      "Hidden",
      "Modified",
      "Bookmark",
      "Diagnostics",
      "Copied",
      StatDecorator,
      "Cut",
    },
  },
  git = {
    enable = true,
    show_on_dirs = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
})
