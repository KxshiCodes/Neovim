local required = { major = 0, minor = 12, patch = 0 }
if vim.version.lt(vim.version(), required) then
  local message = "This configuration only works with nvim version "
    .. required.major
    .. "."
    .. required.minor
    .. "."
    .. required.patch
    .. " and higher."
  vim.notify(message, vim.log.levels.ERROR, {
    id = "nvim version",
    title = "nvim version",
    timeout = false,
  })
  return
end

require("config.options")
require("config.diagnostics")
require("config.lazy")
require("config.autocmds")
require("config.keymaps")
