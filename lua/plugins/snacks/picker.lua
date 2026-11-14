local config_plugins = require("config.plugins")
local ui_icons = require("ui.icons")

local horizontal = function()
  return vim.o.columns >= 120 and "horizontal" or "vertical"
end

local ivy = function()
  return vim.o.columns >= 150 and "ivy" or horizontal()
end

return {
  prompt = " " .. ui_icons.tree.angle.right,
  ui_select = config_plugins.vim.ui.select.snacks,
  formatters = {
    selected = {
      show_always = true,
      unselected = true,
    },
  },
  matcher = {
    cwd_bonus = true,
    frecency = true,
  },
  icons = {
    files = {
      dir = ui_icons.documents.folder.closed,
      dir_open = ui_icons.documents.folder.open,
      file = ui_icons.documents.file.regular,
    },
    tree = {
      vertical = ui_icons.tree.light.vertical,
      middle = ui_icons.tree.light.split,
      last = ui_icons.tree.light.last,
    },
    ui = {
      selected = ui_icons.ui.check,
      unselected = "  ",
    },
    lsp = {
      unavailable = ui_icons.ui.unavailable,
      enabled = ui_icons.ui.enabled,
      disabled = ui_icons.ui.disabled,
      attached = ui_icons.ui.wifi,
    },
    diagnostics = {
      Error = ui_icons.diagnostics.error,
      Warn = ui_icons.diagnostics.warn,
      Info = ui_icons.diagnostics.info,
      Hint = ui_icons.diagnostics.hint,
    },
  },
  actions = {
    qflist = function(picker)
      Snacks.picker.actions.qflist(picker)

      require("quicker").open({
        focus = true,
        min_height = 20,
        max_height = 40,
      })
    end,
  },
  win = {
    input = {
      keys = {
        ["<PageUp>"] = { "preview_scroll_up", mode = { "i", "n" } },
        ["<PageDown>"] = { "preview_scroll_down", mode = { "i", "n" } },
        ["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
        ["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
        ["<a-d>"] = false,
        ["<a-f>"] = false,
        ["<a-h>"] = false,
        ["<a-i>"] = false,
        ["<a-m>"] = false,
        ["<a-p>"] = false,
        ["<a-w>"] = false,
      },
    },
    list = {
      keys = {
        ["<PageUp>"] = "preview_scroll_up",
        ["<PageDown>"] = "preview_scroll_down",
        ["<C-u>"] = "preview_scroll_up",
        ["<C-d>"] = "preview_scroll_down",
        ["<a-d>"] = false,
        ["<a-f>"] = false,
        ["<a-h>"] = false,
        ["<a-i>"] = false,
        ["<a-m>"] = false,
        ["<a-p>"] = false,
        ["<a-w>"] = false,
      },
    },
    preview = {
      keys = {
        ["<PageUp>"] = "preview_scroll_up",
        ["<PageDown>"] = "preview_scroll_down",
        ["<C-u>"] = "preview_scroll_up",
        ["<C-d>"] = "preview_scroll_down",
        ["<a-w>"] = false,
      },
    },
  },
  layout = {
    cycle = true,
    preset = horizontal,
  },
  layouts = {
    ivy = {
      layout = {
        backdrop = false,
        width = 0,
        height = 0.4,
        min_height = 30,
        row = -1,
        box = "horizontal",
        {
          box = "vertical",
          title = "{title}",
          border = "rounded",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" },
        },
        { win = "preview", title = "{preview}", width = 0.6, border = "rounded" },
      },
    },
    horizontal = {
      layout = {
        backdrop = true,
        width = 0.8,
        min_width = 120,
        height = 0.8,
        box = "horizontal",
        {
          box = "vertical",
          title = "{title}",
          border = "rounded",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" },
        },
        { win = "preview", title = "{preview}", width = 0.6, border = "rounded" },
      },
    },
    vertical = {
      layout = {
        backdrop = true,
        width = 0.8,
        min_width = 100,
        height = 0.8,
        box = "vertical",
        {
          box = "vertical",
          title = "{title}",
          border = "rounded",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" },
        },
        { win = "preview", title = "{preview}", height = 0.7, border = "rounded" },
      },
    },
    select = {
      layout = {
        backdrop = false,
        width = 0.3,
        min_width = 80,
        height = 0.3,
        min_height = 40,
        box = "vertical",
        border = "rounded",
        title = "{title}",
        { win = "input", height = 1, border = "bottom" },
        { win = "list", border = "none" },
      },
    },
    colorschemes_layout = {
      layout = {
        backdrop = false,
        width = 0.3,
        min_width = 60,
        height = 0.3,
        min_height = 40,
        box = "vertical",
        border = "rounded",
        title = "{title}",
        { win = "input", height = 1, border = "bottom" },
        { win = "list", border = "none" },
        { win = "preview", height = 1, border = "top" },
      },
    },
  },
  sources = {
    recent = {
      hidden = true,
      ignored = true,
    },
    projects = { layout = "vertical" },

    grep = { layout = ivy() },
    grep_word = { layout = ivy() },
    grep_buffers = { layout = ivy() },
    lines = { layout = ivy() },

    buffers = {
      layout = horizontal(),
      finder = "buffers",
      format = "buffer",
      hidden = true,
      unloaded = false,
      current = false,
      sort_lastused = true,
      win = {
        input = {
          keys = {
            ["dd"] = "bufdelete",
            ["<C-x>"] = { "bufdelete", mode = { "n", "i" } },
          },
        },
        list = {
          keys = {
            ["dd"] = "bufdelete",
            ["<C-x>"] = "bufdelete",
          },
        },
      },
    },

    autocmds = { layout = "select" },
    commands = { layout = "select" },
    colorschemes = { layout = "colorschemes_layout" },
    highlights = { layout = "select" },
    icons = { layout = "select" },
    keymaps = {
      layout = {
        preset = "select",
        layout = { width = 0.6, min_width = 80 },
      },
    },
    registers = {
      layout = {
        preset = "select",
        layout = { width = 0.6, min_width = 80 },
      },
    },
    spelling = { layout = "select" },
    command_history = { layout = "select" },
    search_history = { layout = "select" },
    undo = {
      layout = {
        preview = true,
        preset = "select",
        layout = { width = 0.6, min_width = 80 },
      },
    },
    cliphist = { layout = "select" },
    pickers = { layout = "select" },

    git_log = { layout = "vertical" },
    git_log_file = { layout = "vertical" },
    git_status = { layout = "vertical" },
    git_diff = { layout = "vertical" },
    git_branches = { layout = "vertical" },
    notifications = { layout = "vertical" },

    lsp_config = { layout = { preset = "select" } },
    lsp_declarations = { layout = ivy() },
    lsp_definitions = { layout = ivy() },
    lsp_type_definitions = { layout = ivy() },
    lsp_implementations = { layout = ivy() },
    lsp_incoming_calls = { layout = ivy() },
    lsp_outgoing_calls = { layout = ivy() },
    lsp_references = { layout = ivy() },
    lsp_symbols = { layout = horizontal() },
    lsp_workspace_symbols = { layout = horizontal() },

    qflist = { layout = "vertical" },
    loclist = { layout = "vertical" },
    diagnostics = { layout = "vertical" },
    diagnostics_buffer = { layout = "vertical" },
    todo_comments = { layout = "vertical" },

    yanky = {
      layout = {
        preview = true,
        preset = "select",
        layout = { width = 0.6, min_width = 80 },
      },
    },
  },
}
