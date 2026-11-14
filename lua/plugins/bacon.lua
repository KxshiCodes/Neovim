-- You must enable locations export in bacon. Add this to your `prefs.toml` or `bacon.toml` file:
-- ```toml
-- [exports.locations]
-- auto = true
-- line_format = "{kind} {path}:{line}:{column} {message}"
-- path = ".bacon-locations"
-- ```

return {
  "Canop/nvim-bacon",
  cond = require("config.languages").is_enabled("rust"),
  cmd = {
    "BaconLoad",
    "BaconShow",
    "BaconList",
    "BaconPrevious",
    "BaconNext",
  },
  ft = {
    "rust",
  },
  opts = {
    quickfix = {
      enabled = true, -- populate the quickfix list with bacon errors and warnings
      event_trigger = true, -- trigger the QuickFixCmdPost event after populating the quickfix list
    },
  },
}
