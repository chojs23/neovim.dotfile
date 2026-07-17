local function project_root()
  return vim.fs.root(0, { ".git", "package.json", "Cargo.toml", "go.mod", "pyproject.toml" }) or vim.uv.cwd()
end

local function visual_selection()
  local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
  return table.concat(lines, " ")
end

local function flash(prompt_buffer)
  require("flash").jump({
    pattern = "^",
    label = { after = { 0, 0 } },
    search = {
      mode = "search",
      exclude = {
        function(window)
          return vim.bo[vim.api.nvim_win_get_buf(window)].filetype ~= "TelescopeResults"
        end,
      },
    },
    action = function(match)
      local picker = require("telescope.actions.state").get_current_picker(prompt_buffer)
      picker:set_selection(match.pos[1] - 1)
    end,
  })
end

local function find_command()
  if vim.fn.executable("rg") == 1 then
    return { "rg", "--files", "--color", "never", "-g", "!.git" }
  end
  if vim.fn.executable("fd") == 1 then
    return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
  end
end

-- Telescope is required and configured lazily on the first picker use, so it
-- stays off the startup path. Every keymap below and the LSP pickers in lsp.lua
-- go through ensure() first.
local configured = false
local function ensure()
  if configured then
    return
  end
  configured = true

  local actions = require("telescope.actions")
  local builtin = require("telescope.builtin")

  require("telescope").setup({
    defaults = {
      prompt_prefix = "> ",
      selection_caret = "> ",
      get_selection_window = function()
        local windows = vim.api.nvim_list_wins()
        table.insert(windows, 1, vim.api.nvim_get_current_win())
        for _, window in ipairs(windows) do
          local buffer = vim.api.nvim_win_get_buf(window)
          if vim.bo[buffer].buftype == "" then
            return window
          end
        end
        return 0
      end,
      mappings = {
        i = {
          ["<A-i>"] = function()
            local line = require("telescope.actions.state").get_current_line()
            builtin.find_files({ no_ignore = true, default_text = line })
          end,
          ["<A-h>"] = function()
            local line = require("telescope.actions.state").get_current_line()
            builtin.find_files({ hidden = true, default_text = line })
          end,
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
          ["<C-f>"] = actions.preview_scrolling_down,
          ["<C-b>"] = actions.preview_scrolling_up,
          ["<C-s>"] = flash,
        },
        n = {
          q = actions.close,
          s = flash,
        },
      },
    },
    pickers = {
      find_files = {
        find_command = find_command(),
        hidden = true,
      },
    },
  })
end

local function find_files(options)
  ensure()
  options = options or {}
  local cwd = options.cwd or project_root()
  local builtin = require("telescope.builtin")
  if vim.uv.fs_stat(cwd .. "/.git") then
    builtin.git_files({ cwd = cwd, show_untracked = true })
  else
    builtin.find_files({ cwd = cwd, hidden = true })
  end
end

-- Wrap a telescope.builtin picker so telescope is configured on first use.
local function pick(name, opts)
  return function()
    ensure()
    require("telescope.builtin")[name](opts)
  end
end

local map = vim.keymap.set
local root = project_root

map("n", "<leader>,", pick("buffers", { sort_mru = true, sort_lastused = true }), { desc = "Switch buffer" })
map("n", "<leader>/", function()
  ensure()
  require("telescope.builtin").live_grep({ cwd = root() })
end, { desc = "Grep root directory" })
map("n", "<leader>:", pick("command_history"), { desc = "Command history" })
map("n", "<leader><space>", find_files, { desc = "Find files in root directory" })

map("n", "<leader>fb", pick("buffers", { sort_mru = true, sort_lastused = true, ignore_current_buffer = true }),
  { desc = "Buffers" })
map("n", "<leader>fB", pick("buffers"), { desc = "All buffers" })
map("n", "<leader>fc", function()
  ensure()
  require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config"), hidden = true })
end, { desc = "Find config file" })
map("n", "<leader>ff", find_files, { desc = "Find files in root directory" })
map("n", "<leader>fF", function()
  find_files({ cwd = vim.uv.cwd() })
end, { desc = "Find files in cwd" })
map("n", "<leader>fg", pick("git_files"), { desc = "Find Git files" })
map("n", "<leader>fr", pick("oldfiles"), { desc = "Recent files" })
map("n", "<leader>fR", function()
  ensure()
  require("telescope.builtin").oldfiles({ cwd = vim.uv.cwd() })
end, { desc = "Recent files in cwd" })

map("n", "<leader>gc", pick("git_commits"), { desc = "Git commits" })
map("n", "<leader>gf", pick("git_bcommits"), { desc = "Git current file history" })
map("n", "<leader>gl", pick("git_commits"), { desc = "Git commits" })
map("n", "<leader>gs", pick("git_status"), { desc = "Git status" })
map("n", "<leader>gS", pick("git_stash"), { desc = "Git stash" })

map("n", '<leader>s"', pick("registers"), { desc = "Registers" })
map("n", "<leader>s/", pick("search_history"), { desc = "Search history" })
map("n", "<leader>sa", pick("autocommands"), { desc = "Autocommands" })
map("n", "<leader>sb", pick("current_buffer_fuzzy_find"), { desc = "Buffer lines" })
map("n", "<leader>sc", pick("command_history"), { desc = "Command history" })
map("n", "<leader>sC", pick("commands"), { desc = "Commands" })
map("n", "<leader>sd", pick("diagnostics"), { desc = "Diagnostics" })
map("n", "<leader>sD", pick("diagnostics", { bufnr = 0 }), { desc = "Buffer diagnostics" })
map("n", "<leader>sg", function()
  ensure()
  require("telescope.builtin").live_grep({ cwd = root() })
end, { desc = "Grep root directory" })
map("n", "<leader>sG", pick("live_grep"), { desc = "Grep cwd" })
map("n", "<leader>sh", pick("help_tags"), { desc = "Help pages" })
map("n", "<leader>sH", pick("highlights"), { desc = "Highlight groups" })
map("n", "<leader>sj", pick("jumplist"), { desc = "Jumplist" })
map("n", "<leader>sk", pick("keymaps"), { desc = "Keymaps" })
map("n", "<leader>sl", pick("loclist"), { desc = "Location list" })
map("n", "<leader>sM", pick("man_pages"), { desc = "Man pages" })
map("n", "<leader>sm", pick("marks"), { desc = "Marks" })
map("n", "<leader>so", pick("vim_options"), { desc = "Options" })
map("n", "<leader>sR", pick("resume"), { desc = "Resume" })
map("n", "<leader>sq", pick("quickfix"), { desc = "Quickfix list" })
map("n", "<leader>sw", function()
  ensure()
  require("telescope.builtin").grep_string({ cwd = root(), word_match = "-w" })
end, { desc = "Word in root directory" })
map("n", "<leader>sW", function()
  ensure()
  require("telescope.builtin").grep_string({ word_match = "-w" })
end, { desc = "Word in cwd" })
map("x", "<leader>sw", function()
  ensure()
  require("telescope.builtin").grep_string({ cwd = root(), search = visual_selection() })
end, { desc = "Selection in root directory" })
map("x", "<leader>sW", function()
  ensure()
  require("telescope.builtin").grep_string({ search = visual_selection() })
end, { desc = "Selection in cwd" })
map("n", "<leader>uC", pick("colorscheme"), { desc = "Colorscheme preview" })
map("n", "<leader>ss", pick("lsp_document_symbols"), { desc = "Document symbols" })
map("n", "<leader>sS", pick("lsp_dynamic_workspace_symbols"), { desc = "Workspace symbols" })

return { ensure = ensure }
