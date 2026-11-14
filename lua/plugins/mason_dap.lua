return {
  "jay-babu/mason-nvim-dap.nvim",
  enabled = require("config.plugins").dap.enable,
  dependencies = {
    "mason-org/mason.nvim",
    "mfussenegger/nvim-dap",
  },
  opts = {
    ensure_installed = {
      "codelldb",
      "python",
    },
  },
}
