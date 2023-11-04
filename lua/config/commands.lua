vim.api.nvim_create_user_command("Bottom", function()
  require("utils.term").system_info_toggle()
end, {})
