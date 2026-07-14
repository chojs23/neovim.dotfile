if not vim.pack or not vim.pack.add then
  error("requires a Neovim build with vim.pack support")
end

-- Must be defined before the first vim.pack.add() call to catch its events.
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("pack_hooks", { clear = true }),
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
      require("nvim-treesitter").update()
    end

    -- Synchronous so the binary exists before setup() runs on first install.
    if ev.data.spec.name == "im-switch.nvim" and ev.data.kind ~= "delete" then
      vim.system({ "make", "build" }, { cwd = ev.data.path }):wait()
    end
  end,
})

vim.pack.add({
  "https://github.com/RRethy/base16-nvim",
  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/nvim-mini/mini.hipatterns",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/nvim-mini/mini.surround",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/folke/noice.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9") },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/folke/flash.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/mbbill/undotree",
  "https://github.com/petertriho/nvim-scrollbar",
  "https://github.com/kevinhwang91/nvim-hlslens",
  "https://github.com/chrisgrieser/nvim-origami",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/mrjones2014/smart-splits.nvim",
  "https://github.com/chojs23/im-switch.nvim",
}, {
  load = false,
  confirm = false,
})
