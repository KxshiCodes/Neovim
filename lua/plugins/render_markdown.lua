local ui_icons = require("ui.icons")

return {
  "MeanderingProgrammer/render-markdown.nvim",
  cond = require("config.languages").is_enabled("markdown"),
  dependencies = {
    "neovim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.icons",
    "folke/which-key.nvim",
  },
  cmd = {
    "RenderMarkdown",
  },
  ft = {
    "markdown",
  },
  keys = {
    {
      "<localleader>r",
      function()
        require("render-markdown").toggle()
      end,
      desc = "Toggle render",
      ft = {
        "markdown",
      },
    },
    {
      "<localleader>e",
      function()
        require("render-markdown").expand()
      end,
      desc = "Expand render",
      ft = {
        "markdown",
      },
    },
    {
      "<localleader>c",
      function()
        require("render-markdown").contract()
      end,
      desc = "Contract render",
      ft = {
        "markdown",
      },
    },
  },
  opts = {
    completions = {
      lsp = { enabled = true },
      blink = { enabled = true },
    },
    heading = {
      position = "inline",
      icons = ui_icons.ui.header,
      backgrounds = {},
    },
    code = {
      width = "block",
      style = "normal",
    },
    link = {
      hyperlink = ui_icons.ui.link,
      custom = {
        python = {
          pattern = "%.py$",
          icon = ui_icons.language.python,
        },
        rust = {
          pattern = "%.rs$",
          icon = ui_icons.language.rust,
        },
      },
    },
    sign = { enabled = false },
    on = {
      attach = function(opts)
        local which_key = require("which-key")

        which_key.add({
          {
            buffer = opts.buf,
            { "<localleader>", group = "markdown" },
            { "<localleader>p", group = "live preview" },
          },
        })
      end,
    },
  },
}
