local ui_icons = require("ui.icons")

return {
  "folke/noice.nvim",
  version = false,
  dependencies = {
    "neovim-treesitter/nvim-treesitter",
    "MunifTanjim/nui.nvim",
    "folke/snacks.nvim",
  },
  lazy = false,
  priority = 500,
  keys = {
    { "<leader>nm", "<cmd>Noice snacks<cr>", desc = "Show messages" },
  },
  opts = {
    cmdline = { enabled = true },
    messages = { enabled = true, view = "notify" },
    popupmenu = { enabled = false },
    notify = { enabled = false },
    lsp = {
      progress = { enabled = false },
      hover = { enabled = false },
      signature = { enabled = false },
      documentation = { enabled = false },
      message = { enabled = false },
    },
    format = {
      level = {
        icons = {
          error = ui_icons.diagnostics.error,
          warn = ui_icons.diagnostics.warn,
          info = ui_icons.diagnostics.info,
        },
      },
    },
    views = {
      notify = {
        backend = "snacks",
        format = { "{message}" },
        replace = false,
        merge = false,
      },
      mini = {
        format = { "{message}" },
        timeout = 5000,
        position = { row = -2, col = -1 },
      },
    },
    routes = {
      {
        view = "notify",
        filter = {
          event = "msg_show",
          kind = { "echo", "echomsg", "lua_print", "list_cmd" },
        },
        opts = { title = "Messages" },
      },
      {
        filter = {
          event = "msg_show",
          kind = "search_count",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "%d+L, %d+B",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "second ago",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "seconds ago",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "more lines",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "fewer lines",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "Hunk",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "yanked",
        },
        opts = { skip = true },
      },
    },
  },
}
