return {
  "mfussenegger/nvim-dap",
  enabled = require("config.plugins").dap.enable,
  keys = {
    { "<leader>xb", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
    { "<leader>xs", "<cmd>DapContinue<cr>", desc = "Start/continue" },
    { "<leader>xq", "<cmd>DapTerminate<cr>", desc = "Terminate" },
    { "<leader>xi", "<cmd>DapStepInto<cr>", desc = "Step into" },
    { "<leader>xo", "<cmd>DapStepOver<cr>", desc = "Step over" },
    { "<leader>xO", "<cmd>DapStepOut<cr>", desc = "Step out" },
  },
}
