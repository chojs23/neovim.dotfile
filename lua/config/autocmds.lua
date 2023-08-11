-- vim.api.nvim_set_hl(0, "Comment", { fg = "#ffffff" })
-- vim.api.nvim_set_hl(0, "@comment", { link = "Comment" }) -- fwfefw
vim.cmd([[     
   augroup ColorSchemeOverride         
   au!         
   au ColorScheme *         
   \ highlight! Comment cterm=italic gui=italic guifg=#828282         
\|  highlight! GitSignsCurrentLineBlame cterm=italic gui=italic
\|  highlight! Visual guibg=#424242 
]])
-- vim.cmd([[highlight Comment guifg=#ffffff]])
vim.api.nvim_exec_autocmds("ColorScheme", {})
