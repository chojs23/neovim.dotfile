return {
  {
    "mfussenegger/nvim-dap-python",
    -- Lua 5.1 compatibility error
    enabled = false,
    keys = {
      {
        "<leader>dPt",
        function()
          require("dap-python").test_method()
        end,
        desc = "Debug Method",
        ft = "python",
      },
      {
        "<leader>dPc",
        function()
          require("dap-python").test_class()
        end,
        desc = "Debug Class",
        ft = "python",
      },
    },
    config = function()
      require("dap-python").setup("debugpy-adapter")
    end,
  },
}
