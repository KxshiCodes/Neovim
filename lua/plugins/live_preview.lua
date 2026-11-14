return {
  "brianhuster/live-preview.nvim",
  cond = require("config.languages").is_enabled("markdown"),
  dependencies = {
    "folke/snacks.nvim",
  },
  cmd = {
    "LivePreview",
  },
  ft = {
    "markdown",
  },
  keys = {
    {
      "<localleader>ps",
      "<cmd>LivePreview start<cr>",
      desc = "Start live preview",
      ft = {
        "markdown",
      },
    },
    {
      "<localleader>pq",
      "<cmd>LivePreview close<cr>",
      desc = "Stop live preview",
      ft = {
        "markdown",
      },
    },
    {
      "<localleader>pp",
      "<cmd>LivePreview pick<cr>",
      desc = "Pick live preview",
      ft = {
        "markdown",
      },
    },
  },
}
