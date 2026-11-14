return {
  "mawkler/modicator.nvim",
  dependencies = {
    "folke/tokyonight.nvim",
  },
  event = {
    "VeryLazy",
    "BufRead",
    "ModeChanged",
  },
  init = function()
    vim.opt.cursorline = true
    vim.opt.number = true
    vim.opt.termguicolors = true
  end,
  opts = {
    show_warnings = true,
    highlights = {
      defaults = {
        bold = false,
        italic = false,
      },
      use_cursorline_background = false,
    },
    integration = {
      lualine = {
        enabled = true,
        mode_section = nil,
        highlight = "bg",
      },
    },
  },
}
