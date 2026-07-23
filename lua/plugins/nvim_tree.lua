local api = require("nvim-tree.api")

-- Shows "rw-r--r-- 1.2K" right-aligned for each file
local stats_min_width = 38
local home = vim.fs.normalize(assert(vim.uv.os_homedir(), "home directory unavailable"))
local home_git_disabled = false

local function home_git_ignores(path)
  path = vim.fs.normalize(path)
  if path == home or not vim.startswith(path, home .. "/") then
    return false
  end

  local result = vim.system({ "git", "-C", home, "check-ignore", "-q", "--", path }):wait()
  return result.code == 0
end

local function disable_home_git(git_root)
  return home_git_disabled and vim.fs.normalize(git_root) == home
end

local function set_root(path)
  local disable = home_git_ignores(path)
  if disable == home_git_disabled then
    return
  end

  home_git_disabled = disable

  -- nvim-tree caches Git roots. Clear the cache when the requested tree
  -- switches between home-tracked and home-ignored paths.
  require("nvim-tree.git").purge_state()
end

-- Directory arguments are hijacked before the explorer keymaps run, so apply
-- the same Git policy before nvim-tree handles their buffer event.
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("nvim_tree_root_policy", { clear = true }),
  callback = function(event)
    local path = vim.api.nvim_buf_get_name(event.buf)
    if vim.fn.isdirectory(path) == 1 then
      set_root(path)
    end
  end,
})

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
  -- Nodes carry the stat the explorer already collected. Stat again only
  -- when it is missing, to avoid syscalls for every node on each render.
  local stat = node.fs_stat or vim.uv.fs_stat(node.absolute_path)
  if not stat then
    return nil
  end
  return {
    { str = rwx(stat.mode) .. " " .. human_size(stat.size), hl = { "Comment" } },
  }
end

-- The decorator only runs on render, so the tree must be redrawn when
-- its window is resized across the threshold. Redraw only on that
-- crossing, and with the renderer alone: api.tree.reload() rescans the
-- filesystem and git status, which made incremental resizing
-- (option+left/right) stutter.
local stats_shown = nil

vim.api.nvim_create_autocmd("WinResized", {
  group = vim.api.nvim_create_augroup("nvim_tree_stats_resize", { clear = true }),
  callback = function()
    local winid = api.tree.winid()
    if not winid or not vim.tbl_contains(vim.v.event.windows or {}, winid) then
      return
    end

    local show = vim.api.nvim_win_get_width(winid) >= stats_min_width
    if show == stats_shown then
      return
    end
    stats_shown = show

    -- Internal but draw-only API. Falls back to the heavy reload if a
    -- future nvim-tree update removes it.
    local ok, explorer = pcall(function()
      return require("nvim-tree.core").get_explorer()
    end)
    if ok and explorer and explorer.renderer then
      explorer.renderer:draw()
    else
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
    disable_for_dirs = disable_home_git,
    show_on_dirs = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
})

return {
  set_root = set_root,
}
