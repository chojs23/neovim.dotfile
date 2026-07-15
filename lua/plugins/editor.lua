local function project_root()
  return vim.fs.root(0, { ".git", "package.json", "Cargo.toml", "go.mod", "pyproject.toml" }) or vim.uv.cwd()
end

vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle({ path = project_root(), find_file = true })
end, { desc = "Explorer root directory" })
vim.keymap.set("n", "<leader>E", function()
  require("nvim-tree.api").tree.toggle({ path = vim.uv.cwd(), find_file = true })
end, { desc = "Explorer cwd" })

require("flash").setup({
  mode = "fuzzy",
  modes = {
    search = { enabled = false },
    char = { keys = { "f", "F" } },
  },
})

vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })

vim.o.timeout = true
vim.o.timeoutlen = 300
require("which-key").setup({
  win = { border = "single" },
  spec = {
    { "<leader>f",  group = "file/find" },
    { "<leader>g",  group = "git" },
    { "<leader>gh", group = "hunks" },
    { "<leader>s",  group = "search" },
    { "<leader>sn", group = "Noice" },
    { "<leader>u",  group = "toggle" },
  },
})

-- gitsigns loads on the first real file so it stays off the startup path.
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("gitsigns_lazy", { clear = true }),
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" }, { load = true, confirm = false })
    require("gitsigns").setup({
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      current_line_blame = true,
      current_line_blame_formatter = "<abbrev_sha> - <author>, <author_time:%Y-%m-%d> - <summary>",
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
        ignore_whitespace = false,
      },
      on_attach = function(buffer)
        local gs = require("gitsigns")

        local function map(mode, lhs, rhs, description)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, silent = true, desc = description })
        end

        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Previous Hunk")
        map("n", "]H", function()
          gs.nav_hunk("last")
        end, "Last Hunk")
        map("n", "[H", function()
          gs.nav_hunk("first")
        end, "First Hunk")
        map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>ghB", gs.blame, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, "Diff This Against ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk")
      end,
    })

    -- Now that gitsigns is loaded, wire its hunks into the scrollbar.
    require("scrollbar.handlers.gitsigns").setup()
  end,
})

vim.keymap.set("n", "<leader>t", "<cmd>UndotreeToggle<cr>", { desc = "Undotree" })

require("hlslens").setup({ calm_down = false })
vim.api.nvim_set_hl(0, "HlSearchLens", { link = "Search" })

local search_keys = {
  n = [[<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require("hlslens").start()<cr>]],
  N = [[<cmd>execute('normal! ' . v:count1 . 'N')<cr><cmd>lua require("hlslens").start()<cr>]],
  ["*"] = [[*<cmd>lua require("hlslens").start()<cr>]],
  ["#"] = [[#<cmd>lua require("hlslens").start()<cr>]],
  ["g*"] = [[g*<cmd>lua require("hlslens").start()<cr>]],
  ["g#"] = [[g#<cmd>lua require("hlslens").start()<cr>]],
}
for key, command in pairs(search_keys) do
  vim.keymap.set("n", key, command, { silent = true })
end

require("scrollbar.handlers.search").setup({
  override_lens = function() end,
})
require("scrollbar").setup({
  handlers = {
    cursor = true,
    diagnostic = true,
    -- Wired lazily from the gitsigns callback below so gitsigns stays off the
    -- startup path (enabling it here would require gitsigns at startup).
    gitsigns = false,
    handle = true,
    search = true,
    ale = false,
  },
})

require("origami").setup({
  foldKeymaps = { setup = false },
})
