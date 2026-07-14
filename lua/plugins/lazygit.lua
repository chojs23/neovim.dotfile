local state = { window = nil }

local function project_root()
  return vim.fs.root(0, { ".git" }) or vim.uv.cwd()
end

local function close()
  if state.window and vim.api.nvim_win_is_valid(state.window) then
    vim.api.nvim_win_close(state.window, true)
  end
  state.window = nil
end

local function open(cwd)
  if vim.fn.executable("lazygit") ~= 1 then
    vim.notify("lazygit executable was not found", vim.log.levels.ERROR)
    return
  end

  if state.window and vim.api.nvim_win_is_valid(state.window) then
    close()
    return
  end

  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local buffer = vim.api.nvim_create_buf(false, true)
  vim.bo[buffer].bufhidden = "wipe"

  state.window = vim.api.nvim_open_win(buffer, true, {
    relative = "editor",
    style = "minimal",
    border = "rounded",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2 - 1),
    col = math.floor((vim.o.columns - width) / 2),
  })

  vim.fn.jobstart({ "lazygit" }, {
    cwd = cwd,
    term = true,
    on_exit = function()
      vim.schedule(close)
    end,
  })

  vim.keymap.set("t", "<C-q>", close, { buffer = buffer, desc = "Close LazyGit" })
  vim.cmd.startinsert()
end

vim.api.nvim_create_user_command("LazyGit", function(options)
  open(options.bang and vim.uv.cwd() or project_root())
end, { bang = true })

vim.keymap.set("n", "<leader>gg", function()
  open(project_root())
end, { desc = "LazyGit root directory" })

vim.keymap.set("n", "<leader>gG", function()
  open(vim.uv.cwd())
end, { desc = "LazyGit cwd" })
