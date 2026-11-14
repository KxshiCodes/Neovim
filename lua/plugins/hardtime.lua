local ui_filetypes = require("ui.filetypes")
local ui_style = require("ui.style")

return {
  "m4xshen/hardtime.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  event = {
    "BufRead",
  },
  keys = {
    {
      "<leader>uh",
      "<cmd>Hardtime toggle<cr>",
      desc = "Toggle hardtime",
    },
    {
      "<leader>oh",
      "<cmd>Hardtime report<cr><cmd>set filetype=HardtimeReport<cr>",
      desc = "Open hardtime report",
    },
  },
  opts = {
    max_time = 1000,
    max_count = 5,
    disable_mouse = false,
    disabled_filetypes = ui_filetypes.hardtime,
    restriction_mode = "hint",
    disabled_keys = {
      ["<Up>"] = {},
      ["<Down>"] = {},
      ["<Left>"] = {},
      ["<Right>"] = {},
    },
    restricted_keys = {
      ["<Up>"] = { "n", "x" },
      ["<Down>"] = { "n", "x" },
      ["<Left>"] = { "n", "x" },
      ["<Right>"] = { "n", "x" },
    },
    ui = {
      border = {
        style = ui_style.border.default,
      },
      size = {
        width = 0.3,
        height = 0.5,
      },
    },
  },
}
