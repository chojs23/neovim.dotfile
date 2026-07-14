local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

local function project_root()
  return vim.fs.root(0, { ".git", "package.json", "Cargo.toml", "go.mod", "pyproject.toml" }) or vim.uv.cwd()
end

local function find_files(options)
  options = options or {}
  local cwd = options.cwd or project_root()
  if vim.uv.fs_stat(cwd .. "/.git") then
    builtin.git_files({ cwd = cwd, show_untracked = true })
  else
    builtin.find_files({ cwd = cwd, hidden = true })
  end
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

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
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

local map = vim.keymap.set
local root = project_root

map("n", "<leader>,", function()
  builtin.buffers({ sort_mru = true, sort_lastused = true })
end, { desc = "Switch buffer" })
map("n", "<leader>/", function()
  builtin.live_grep({ cwd = root() })
end, { desc = "Grep root directory" })
map("n", "<leader>:", builtin.command_history, { desc = "Command history" })
map("n", "<leader><space>", find_files, { desc = "Find files in root directory" })

map("n", "<leader>fb", function()
  builtin.buffers({ sort_mru = true, sort_lastused = true, ignore_current_buffer = true })
end, { desc = "Buffers" })
map("n", "<leader>fB", builtin.buffers, { desc = "All buffers" })
map("n", "<leader>fc", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config"), hidden = true })
end, { desc = "Find config file" })
map("n", "<leader>ff", find_files, { desc = "Find files in root directory" })
map("n", "<leader>fF", function()
  find_files({ cwd = vim.uv.cwd() })
end, { desc = "Find files in cwd" })
map("n", "<leader>fg", builtin.git_files, { desc = "Find Git files" })
map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
map("n", "<leader>fR", function()
  builtin.oldfiles({ cwd = vim.uv.cwd() })
end, { desc = "Recent files in cwd" })

map("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
map("n", "<leader>gl", builtin.git_commits, { desc = "Git commits" })
map("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
map("n", "<leader>gS", builtin.git_stash, { desc = "Git stash" })

map("n", '<leader>s"', builtin.registers, { desc = "Registers" })
map("n", "<leader>s/", builtin.search_history, { desc = "Search history" })
map("n", "<leader>sa", builtin.autocommands, { desc = "Autocommands" })
map("n", "<leader>sb", builtin.current_buffer_fuzzy_find, { desc = "Buffer lines" })
map("n", "<leader>sc", builtin.command_history, { desc = "Command history" })
map("n", "<leader>sC", builtin.commands, { desc = "Commands" })
map("n", "<leader>sd", builtin.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>sD", function()
  builtin.diagnostics({ bufnr = 0 })
end, { desc = "Buffer diagnostics" })
map("n", "<leader>sg", function()
  builtin.live_grep({ cwd = root() })
end, { desc = "Grep root directory" })
map("n", "<leader>sG", builtin.live_grep, { desc = "Grep cwd" })
map("n", "<leader>sh", builtin.help_tags, { desc = "Help pages" })
map("n", "<leader>sH", builtin.highlights, { desc = "Highlight groups" })
map("n", "<leader>sj", builtin.jumplist, { desc = "Jumplist" })
map("n", "<leader>sk", builtin.keymaps, { desc = "Keymaps" })
map("n", "<leader>sl", builtin.loclist, { desc = "Location list" })
map("n", "<leader>sM", builtin.man_pages, { desc = "Man pages" })
map("n", "<leader>sm", builtin.marks, { desc = "Marks" })
map("n", "<leader>so", builtin.vim_options, { desc = "Options" })
map("n", "<leader>sR", builtin.resume, { desc = "Resume" })
map("n", "<leader>sq", builtin.quickfix, { desc = "Quickfix list" })
map("n", "<leader>sw", function()
  builtin.grep_string({ cwd = root(), word_match = "-w" })
end, { desc = "Word in root directory" })
map("n", "<leader>sW", function()
  builtin.grep_string({ word_match = "-w" })
end, { desc = "Word in cwd" })
map("x", "<leader>sw", function()
  builtin.grep_string({ cwd = root(), search = visual_selection() })
end, { desc = "Selection in root directory" })
map("x", "<leader>sW", function()
  builtin.grep_string({ search = visual_selection() })
end, { desc = "Selection in cwd" })
map("n", "<leader>uC", builtin.colorscheme, { desc = "Colorscheme preview" })
map("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "Document symbols" })
map("n", "<leader>sS", builtin.lsp_dynamic_workspace_symbols, { desc = "Workspace symbols" })
