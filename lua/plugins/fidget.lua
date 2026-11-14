local config_plugins = require("config.plugins")
local ui_icons = require("ui.icons")

return {
  "j-hui/fidget.nvim",
  enabled = config_plugins.vim.notify.fidget or config_plugins.lsp_notification.fidget,
  cmd = {
    "Fidget",
  },
  event = {
    "LspAttach",
  },
  opts = {
    progress = {
      display = {
        done_icon = ui_icons.ui.check,
      },
    },
    notification = {
      override_vim_notify = config_plugins.vim.notify.fidget,
      window = {
        winblend = 0,
        x_padding = 1,
        y_padding = 1,
        align = "bottom",
      },
    },
  },
}
