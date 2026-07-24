vim.loader.enable()

require("config.options")
require("config.pack")

local plugin_directory = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "plugins")
local plugin_modules = {}

require("plugins.ui")

for name, kind in vim.fs.dir(plugin_directory) do
  if kind == "file" and vim.endswith(name, ".lua") then
    plugin_modules[#plugin_modules + 1] = "plugins." .. name:sub(1, -5)
  end
end

table.sort(plugin_modules)

for _, module in ipairs(plugin_modules) do
  require(module)
end

require("config.keymaps")
require("config.autocmds")
