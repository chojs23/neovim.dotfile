vim.cmd([[
   augroup ColorSchemeOverride
   au!
   au ColorScheme *
   \ highlight! Comment cterm=italic gui=italic guifg=#8a8a8a
\|  highlight! Normal guifg=#d6d6d6
\|  highlight! @variable guifg=#bababa
\|  highlight! @constant guifg=#bababa
\|  highlight! @parameter guifg=#FC9A41
\|  highlight! @property guifg=#ef596f
\|  highlight! GitSignsCurrentLineBlame cterm=italic gui=italic guifg=#8a8a8a
\|  highlight! Visual guibg=#424242
\|  highlight! LspInlayHint guifg=#474747
\|  highlight! Pmenu guibg=#424242
\|  highlight! PmenuThumb guibg=#bdbbbb
\|  highlight! PmenuSel guibg=#222222
\|  highlight! NeoTreeCursorLine guibg=#303030
\|  highlight! NeoTreeGitIgnored guifg=#7a7a7a
]])
vim.api.nvim_exec_autocmds("ColorScheme", {})

-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
--   callback = function()
--     vim.lsp.inlay_hint(0, true)
--   end,
-- })
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
--   callback = function()
--     vim.lsp.inlay_hint(0, false)
--   end,
-- })
-- vim.diagnostic.config({
--   update_in_insert = false,
-- })
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--   update_in_insert = false,
-- })
