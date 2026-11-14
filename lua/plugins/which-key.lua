local ui_icons = require("ui.icons")

return {
  "folke/which-key.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.icons",
  },
  event = {
    "VeryLazy",
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Show which-key",
    },
  },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = function()
    local which_key = require("which-key")

    which_key.add({
      {
        { "gr", group = "code", mode = { "n", "x" } },
        { "grb", group = "block" },
        { "z", group = "fold" },
        { "<leader>b", group = "buffer" },
        { "<leader>f", group = "find", mode = { "n", "x" } },
        { "<leader>g", group = "git", mode = { "n", "x" } },
        { "<leader>gf", group = "find" },
        { "<leader>i", group = "info" },
        { "<leader>l", group = "log" },
        { "<leader>n", group = "notification" },
        { "<leader>o", group = "open" },
        { "<leader>q", group = "quit" },
        { "<leader>s", group = "search" },
        { "<leader>t", group = "todo" },
        { "<leader>u", group = "ui" },
        { "<leader>v", group = "nvim" },
        { "<leader>vh", group = "history" },
        { "<leader>w", proxy = "<c-w>", group = "window" },
        { "<leader>x", group = "debug" },
        { "<leader>xp", group = "python" },
        { "<leader>xu", group = "ui" },
      },
    })

    local opts = {
      preset = "classic",
      sort = { "group", "mod", "alphanum" },
      icons = {
        rules = {
          { pattern = "info", icon = " ", color = "blue" },
          { pattern = "notification", color = "yellow" },
          { pattern = "log", icon = "󰯓 ", color = "orange" },
          { pattern = "open", icon = " ", color = "blue" },
          { pattern = "swap", icon = "󰓡 ", color = "yellow" },
          { pattern = "todo", icon = " ", color = "orange" },

          { pattern = "LSP", icon = " ", color = "blue" },
          { pattern = "block", icon = "󰅪 ", color = "yellow" },
          { pattern = "symbols", icon = "󱔁 ", color = "purple" },

          { pattern = "lua", icon = ui_icons.language.lua, color = "orange" },
          { pattern = "python", icon = ui_icons.language.python, color = "orange" },
          { pattern = "rust", icon = ui_icons.language.rust, color = "orange" },

          { pattern = "neovim", icon = ui_icons.language.neovim, color = "cyan" },
          { pattern = "nvim", icon = ui_icons.language.neovim, color = "cyan" },
          { pattern = "vim", icon = ui_icons.language.vim, color = "cyan" },
        },
      },
    }

    return opts
  end,
}
