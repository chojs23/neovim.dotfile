if vim.env.VSCODE or vim.g.vscode then
  -- use vscode extenstion
else
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
end
