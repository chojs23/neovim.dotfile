vim.loader.enable()

require("config.options")
require("config.pack")

for _, module in ipairs({
  "plugins.colorscheme",
  "plugins.mini",
  "plugins.snacks",
  "plugins.nvim_tree",
  "plugins.treesitter",
  "plugins.telescope",
  "plugins.mason",
  "plugins.blink",
  "plugins.copilot",
  "plugins.lsp",
  "plugins.rustaceanvim",
  "plugins.formatting",
  "plugins.lazygit",
  "plugins.editor",
  "plugins.noice",
  "plugins.lualine",
  "plugins.smart_splits",
  "plugins.im_switch",
}) do
  require(module)
end

require("config.keymaps")
require("config.autocmds")
