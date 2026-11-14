return {
  "rcarriga/nvim-dap-ui",
  enabled = require("config.plugins").dap.enable,
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "folke/lazydev.nvim",
  },
  keys = {
    {
      "<leader>xuo",
      function()
        require("dapui").open()
      end,
      desc = "Open DAP-UI",
    },
    {
      "<leader>xut",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle DAP-UI",
    },
    {
      "<leader>xuf",
      function()
        require("dapui").float_element()
      end,
      desc = "Float DAP-UI",
    },
    {
      "<leader>xue",
      function()
        require("dapui").eval()
      end,
      desc = "Evaluate DAP-UI",
    },
    {
      "<leader>xuq",
      function()
        require("dapui").close()
      end,
      desc = "Quit DAP-UI",
    },
  },
  config = function()
    local dapui = require("dapui")

    dapui.setup()

    local dap = require("dap")

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
