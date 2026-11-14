local ui_filetypes = require("ui.filetypes")
local ui_icons = require("ui.icons")

return {
  "utilyre/barbecue.nvim",
  dependencies = {
    {
      "SmiteshP/nvim-navic",
      dependencies = {
        "neovim/nvim-lspconfig",
      },
    },
    "nvim-tree/nvim-web-devicons",
    "folke/tokyonight.nvim",
  },
  event = {
    "BufRead",
  },
  keys = {
    {
      "<leader>ub",
      "<cmd>Barbecue toggle<cr>",
      desc = "Toggle barbecue",
    },
  },
  opts = {
    exclude_filetypes = ui_filetypes.all,
    show_modified = true,
    theme = "tokyonight",
    symbols = {
      modified = ui_icons.documents.file.edit,
      -- TODO(icons): add icons to module
      ellipsis = "…",
      separator = ui_icons.tree.angle.right,
    },
  },
}
