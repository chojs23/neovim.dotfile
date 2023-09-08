return {
  "jackMort/ChatGPT.nvim",
  enabled = false,
  commit = "a6368d71dc5d320e271c0911a9c1e9e9d2502612",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup()
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    api_key_cmd = nil,
    yank_register = "+",
    edit_with_instructions = {
      diff = false,
      keymaps = {
        close = "<C-c>",
        accept = "<C-y>",
        toggle_diff = "<C-d>",
        toggle_settings = "<C-o>",
        cycle_windows = "<Tab>",
        use_output_as_input = "<C-i>",
      },
    },
    chat = {
      welcome_message = WELCOME_MESSAGE,
      loading_text = "Loading, please wait ...",
      question_sign = "",
      answer_sign = "ﮧ",
      max_line_length = 120,
      sessions_window = {
        border = {
          style = "rounded",
          text = {
            top = " Sessions ",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
      },
    },
  },
  -- "Bryley/neoai.nvim",
  -- dependencies = {
  --   "MunifTanjim/nui.nvim",
  -- },
  -- cmd = {
  --   "NeoAI",
  --   "NeoAIOpen",
  --   "NeoAIClose",
  --   "NeoAIToggle",
  --   "NeoAIContext",
  --   "NeoAIContextOpen",
  --   "NeoAIContextClose",
  --   "NeoAIInject",
  --   "NeoAIInjectCode",
  --   "NeoAIInjectContext",
  --   "NeoAIInjectContextCode",
  -- },
  -- keys = {
  --   { "<leader>as", desc = "summarize text" },
  --   { "<leader>ag", desc = "generate git message" },
  -- },
  -- config = function()
  --   require("neoai").setup({
  --     -- Options go here
  --   })
  -- end,
}
