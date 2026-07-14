local conform = require("conform")

local function autoformat_enabled(buffer)
  local buffer_setting = vim.b[buffer].autoformat
  if buffer_setting ~= nil then
    return buffer_setting
  end

  return vim.g.autoformat ~= false
end

conform.setup({
  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua" },
    fish = { "fish_indent" },
    sh = { "shfmt" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
  },
  format_on_save = function(buffer)
    if autoformat_enabled(buffer) then
      return {}
    end
  end,
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set({ "n", "x" }, "<leader>cf", function()
  conform.format()
end, { desc = "Format" })

vim.keymap.set("n", "<leader>uf", function()
  local enabled = vim.g.autoformat == false
  vim.g.autoformat = enabled
  vim.b.autoformat = nil
  vim.notify("Global auto format " .. (enabled and "enabled" or "disabled"))
end, { desc = "Toggle auto format (global)" })

vim.keymap.set("n", "<leader>uF", function()
  local enabled = not autoformat_enabled(0)
  vim.b.autoformat = enabled
  vim.notify("Buffer auto format " .. (enabled and "enabled" or "disabled"))
end, { desc = "Toggle auto format (buffer)" })
