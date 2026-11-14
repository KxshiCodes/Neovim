local config_plugins = require("config.plugins")
local ui_highlights = require("ui.highlights")

return {
  "HiPhish/rainbow-delimiters.nvim",
  enabled = config_plugins.pairs.rainbow_delimiters,
  event = {
    "BufRead",
  },
  init = function()
    vim.g.rainbow_delimiters = {
      highlight = ui_highlights.rainbow,
    }
  end,
}
