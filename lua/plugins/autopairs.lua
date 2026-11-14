local config_plugins = require("config.plugins")
local ui_filetypes = require("ui.filetypes")

return {
  "windwp/nvim-autopairs",
  enabled = config_plugins.pairs.nvim_autopairs,
  event = {
    "InsertEnter",
  },
  opts = {
    disable_filetype = ui_filetypes.all,
    check_ts = true,
    map_cr = true,
  },
}
