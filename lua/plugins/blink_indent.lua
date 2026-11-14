local config_plugins = require("config.plugins")
local ui_highlights = require("ui.highlights")

return {
  "saghen/blink.indent",
  enabled = config_plugins.indent.blink_indent,
  version = "2",
  event = {
    "BufRead",
  },
  --- @module 'blink.indent'
  --- @type blink.indent.Config
  opts = {
    static = {
      enabled = true,
      char = "▎",
    },
    scope = {
      enabled = true,
      char = "▎",
      priority = 1000,
      highlights = ui_highlights.rainbow,
      underline = {
        enabled = true,
        highlights = ui_highlights.rainbow_underline,
      },
    },
  },
}
