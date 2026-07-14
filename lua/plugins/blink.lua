-- Loading the module itself is cheap, so lsp.lua can still call get_lsp_capabilities() eagerly.
vim.schedule(function()
  require("blink.cmp").setup({
    keymap = { preset = "enter" },
    completion = {
      menu = {
        border = "rounded",
        -- winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:BlinkCmpMenuSelection,Search:None",
        draw = {
          -- Highlight completion labels with treesitter, like code.
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        window = {
          border = "rounded",
          -- winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None",
        },
      },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    -- Falls back to the Lua matcher if the prebuilt Rust binary is unavailable.
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = {
      enabled = true,
      window = {
        border = "rounded",
        -- winhighlight = "Normal:Normal,FloatBorder:Normal",
      },
    },
  })
end)
