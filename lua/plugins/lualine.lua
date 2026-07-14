local colors = {
  green = "#98be65",
  orange = "#FF8800",
  white = "#ffffff",
}

local noice_status = require("noice").api.status

local function active_lsp()
  local filetype = vim.bo.filetype
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    local filetypes = client.config.filetypes
    if not filetypes or vim.tbl_contains(filetypes, filetype) then
      return client.name
    end
  end
  return "No Active Lsp"
end

require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
    disabled_filetypes = {
      statusline = { "dashboard", "ministarter" },
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      {
        "diagnostics",
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      { "filename", path = 1 },
    },
    lualine_x = {
      {
        noice_status.command.get,
        cond = noice_status.command.has,
        color = { fg = colors.orange },
      },
      {
        noice_status.mode.get,
        cond = noice_status.mode.has,
        color = { fg = colors.orange },
      },
      { active_lsp, color = { fg = colors.white, gui = "bold" } },
      {
        "encoding",
        fmt = string.upper,
        cond = function()
          return vim.fn.winwidth(0) > 80
        end,
        color = { fg = colors.green, gui = "bold" },
      },
      {
        "fileformat",
        fmt = string.upper,
        icons_enabled = false,
        color = { fg = colors.green, gui = "bold" },
      },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
