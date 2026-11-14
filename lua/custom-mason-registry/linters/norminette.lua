local pattern = "(%a+)" -- capture "Error"
  .. ":%s+"
  .. "([%u_]+)" -- capture error code (e.g. TAB_INSTEAD_SPC)
  .. "%s+%(line:%s+"
  .. "(%d+)" -- capture line number
  .. ",%s+col:%s+"
  .. "(%d+)" -- capture column number
  .. "%):%s+"
  .. "(.+)" -- capture message corresponding to error code (e.g. "Found tab when expecting space")

local groups = {
  "severity",
  "code",
  "lnum",
  "col",
  "message",
}

local severity_map = {
  Error = vim.diagnostic.severity.WARN,
}

local defaults = {
  severity = vim.diagnostic.severity.WARN,
  source = "norminette",
}

return {
  cmd = "norminette",
  args = { "--no-colors", "--use-gitignore" },
  stdin = false,
  append_fname = true,
  stream = "stdout",
  ignore_exitcode = true,
  parser = require("lint.parser").from_pattern(pattern, groups, severity_map, defaults, {}),
}
