local config_plugins = require("config.plugins")
local ui_style = require("ui.style")

return {
  "stevearc/dressing.nvim",
  enabled = config_plugins.vim.ui.input.dressing or config_plugins.vim.ui.select.dressing,
  version = false,
  dependencies = {
    "folke/snacks.nvim",
  },
  event = {
    "BufRead",
  },
  opts = {
    input = {
      enabled = config_plugins.vim.ui.input.dressing,
      border = ui_style.border.default,
      override = function(conf)
        conf.row = 0
        conf.col = -1
        return conf
      end,
      mappings = {
        i = {
          ["<Esc>"] = "Close",
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
        },
        n = {
          ["<Esc>"] = "Close",
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
        },
      },
    },
    select = {
      enabled = config_plugins.vim.ui.select.dressing,
      backend = { "snacks_picker" },
    },
  },
}
