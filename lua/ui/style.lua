local M = {}

M.border = {
  default = "rounded",
  none = "none",
  rounded = "rounded",
  single = "single",
  double = "double",
  bold = "bold",
  shadow = "shadow",
  solid = "solid",
  padded = "padded",
}

M.floating_window = {
  max_width = 100,
  max_height = 50,
  config = function(opts)
    local default = {
      border = M.border.default,
      max_width = M.floating_window.max_width,
      max_height = M.floating_window.max_height,
      focus = true,
      focusable = true,
      auto_focus = true,
    }

    return vim.tbl_deep_extend("force", default, opts or {})
  end,
}

return M
