return {
  "catgoose/nvim-colorizer.lua",
  event = {
    "BufRead",
  },
  keys = {
    {
      "<leader>uc",
      "<cmd>ColorizerToggle<cr>",
      desc = "Toggle colorizer",
    },
  },
  opts = {
    lazy_load = true,
    options = {
      parsers = {
        names = { enable = false },
        hex = { enable = true },
        rgb = { enable = true },
        xterm = { enable = true },
      },
      display = {
        ---@type "background"|"foreground"|"virtualtext"
        mode = "background",
        background = {
          bright_fg = "#000000",
          dark_fg = "#ffffff",
        },
        priority = {
          default = vim.hl.priorities.diagnostics,
          lsp = vim.hl.priorities.user,
        },
      },
      always_update = true,
    },
  },
}
