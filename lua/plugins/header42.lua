return {
  "https://codeberg.org/42nerds/header42.nvim",
  cond = require("config.languages").is_enabled("c"),
  version = false,
  cmd = {
    "Header42",
  },
  ft = {
    "c",
    "cpp",
  },
  opts = {
    domain = "student.codam.nl",
  },
}
