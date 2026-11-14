return {
  "mfussenegger/nvim-dap-python",
  enabled = require("config.plugins").dap.enable and require("config.languages").is_enabled("python"),
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  ft = {
    "python",
  },
  keys = {
    {
      "<leader>xpm",
      function()
        require("dap-python").test_method()
      end,
      desc = "Test method",
      ft = {
        "python",
      },
    },
    {
      "<leader>xpc",
      function()
        require("dap-python").test_class()
      end,
      desc = "Test class",
      ft = {
        "python",
      },
    },
    {
      "<leader>xps",
      function()
        require("dap-python").debug_selection()
      end,
      desc = "Debug selection",
      mode = "x",
      ft = {
        "python",
      },
    },
  },
  config = function()
    local dap_python = require("dap-python")

    local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"

    dap_python.setup(path)
  end,
}
