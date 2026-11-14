local ui_icons = require("ui.icons")

return {
  "chrisgrieser/nvim-chainsaw",
  keys = {
    {
      "<leader>lv",
      function()
        require("chainsaw").variableLog()
      end,
      desc = "Log variable",
    },
    {
      "<leader>lV",
      function()
        require("chainsaw").objectLog()
      end,
      desc = "Log variable (inspect)",
    },
    {
      "<leader>lp",
      function()
        require("chainsaw").typeLog()
      end,
      desc = "Log variable type",
    },
    {
      "<leader>la",
      function()
        require("chainsaw").assertLog()
      end,
      desc = "Assert variable",
    },
    {
      "<leader>le",
      function()
        require("chainsaw").emojiLog()
      end,
      desc = "Log emoji",
    },
    {
      "<leader>ll",
      function()
        require("chainsaw").messageLog()
      end,
      desc = "Log message",
    },
    {
      "<leader>lt",
      function()
        -- 1st call: start measuring the time
        -- 2nd call: log the time duration since the 1st statement
        require("chainsaw").timeLog()
      end,
      desc = "Log time",
    },
    {
      "<leader>lr",
      function()
        require("chainsaw").removeLogs()
      end,
      desc = "Remove logs",
      mode = { "n", "x" },
    },
  },
  opts = function()
    return {
      visuals = {
        icon = ui_icons.saw,
        nvimSatelliteIntegration = {
          enabled = false,
        },
      },
      preCommitHook = {
        enabled = true,
        notifyOnInstall = true,
        dontInstallInDirs = {},
      },
      logTypes = {
        emojiLog = {
          emojis = { "🔵", "🟩", "⭐", "⭕", "💜", "🔲" },
        },
      },
      logStatements = require("chainsaw.config.log-statements-data").logStatements,
      supersets = require("chainsaw.config.log-statements-data").supersets,
    }
  end,
}
