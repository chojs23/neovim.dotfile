require("config.options")
require("config.pack")

for _, module in ipairs({
  "plugins.colorscheme",
  "plugins.mini",
  "plugins.snacks",
  "plugins.treesitter",
  "plugins.telescope",
  "plugins.mason",
  "plugins.lsp",
  "plugins.rustaceanvim",
  "plugins.formatting",
  "plugins.lazygit",
  "plugins.editor",
  "plugins.noice",
  "plugins.lualine",
  "plugins.smart_splits",
}) do
  require(module)
end

require("config.keymaps")
require("config.autocmds")
