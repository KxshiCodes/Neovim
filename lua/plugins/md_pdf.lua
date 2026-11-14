return {
  "arminveres/md-pdf.nvim",
  cond = require("config.languages").is_enabled("markdown"),
  branch = "main",
  ft = {
    "markdown",
  },
  keys = {
    {
      "<localleader>P",
      function()
        require("md-pdf").convert_md_to_pdf()
      end,
      desc = "Convert to PDF",
      ft = {
        "markdown",
      },
    },
  },
  opts = {},
}
