local ui_style = require("ui.style")

return {
  "Saecki/crates.nvim",
  cond = require("config.languages").is_enabled("rust"),
  tag = "stable",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = {
    "BufRead Cargo.toml",
  },
  opts = {
    completion = {
      crates = { enabled = true },
    },
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
    popup = {
      border = ui_style.border.default,
      text = {
        pill_left = "▐",
        pill_right = "▌",
      },
    },
  },
}
