local config_plugins = require("config.plugins")
local ui_highlights = require("ui.highlights")
local ui_icons = require("ui.icons")
local ui_style = require("ui.style")

-- https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md#-examples
local function lsp_notification()
  local group = vim.api.nvim_create_augroup("snacks_lsp_progress", { clear = true })
  local progress = vim.defaulttable()

  vim.api.nvim_create_autocmd("LspProgress", {
    group = group,
    desc = "Show LSP progress",
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local value = ev.data.params.value
      if not client or type(value) ~= "table" then
        return
      end
      local p = progress[client.id]

      for i = 1, #p + 1 do
        if i == #p + 1 or p[i].token == ev.data.params.token then
          p[i] = {
            token = ev.data.params.token,
            msg = ("[%3d%%] %s%s"):format(
              value.kind == "end" and 100 or value.percentage or 100,
              value.title or "",
              value.message and (" **%s**"):format(value.message) or ""
            ),
            done = value.kind == "end",
          }
          break
        end
      end

      local msg = {}
      progress[client.id] = vim.tbl_filter(function(v)
        return table.insert(msg, v.msg) or not v.done
      end, p)

      vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
        id = "lsp_progress",
        title = client.name,
        opts = function(notif)
          local spinner = ui_icons.ui.spinner

          notif.icon = #progress[client.id] == 0 and ui_icons.ui.check
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
      })
    end,
  })
end

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  keys = {
    {
      "<leader>fc",
      function()
        Snacks.picker.resume()
      end,
      desc = "Continue search",
    },

    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find file",
    },
    {
      "<leader>fa",
      function()
        Snacks.picker.files({
          hidden = true,
          ignored = true,
        })
      end,
      desc = "Find any file",
    },
    {
      "<leader>f.",
      function()
        Snacks.picker.files({
          hidden = true,
          ignored = true,
          dirs = { vim.fn.expand("%:h") },
        })
      end,
      desc = "Find adjacent file",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Find recent file",
    },
    {
      "<leader>fs",
      function()
        Snacks.picker.smart({
          hidden = true,
          ignored = true,
        })
      end,
      desc = "Find smart",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Find project",
    },

    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Search",
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.grep()
      end,
      desc = "Search",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Search word",
      mode = { "n", "x" },
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Search buffers",
    },
    {
      "<leader>sl",
      function()
        Snacks.picker.lines()
      end,
      desc = "Search lines",
    },

    {
      "<leader>bb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "List buffers",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete.delete()
      end,
      desc = "Delete buffer",
    },
    {
      "<leader>bo",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Delete other buffers",
    },
    {
      "<leader>ba",
      function()
        Snacks.bufdelete.all()
      end,
      desc = "Delete all buffers",
    },

    {
      "<leader>ih",
      function()
        Snacks.picker.help()
      end,
      desc = "Show help pages",
    },
    {
      "<leader>im",
      function()
        Snacks.picker.man()
      end,
      desc = "Show man pages",
    },

    {
      "<leader>va",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "List autocommands",
    },
    {
      "<leader>vc",
      function()
        Snacks.picker.commands()
      end,
      desc = "List commands",
    },
    {
      "<leader>vC",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "List colorschemes",
    },
    {
      "<leader>vH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "List highlights",
    },
    {
      "<leader>vi",
      function()
        Snacks.picker.icons()
      end,
      desc = "List icons",
    },
    {
      "<leader>vj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "List jump locations",
    },
    {
      "<leader>vk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "List keymaps",
    },
    {
      "<leader>vl",
      function()
        Snacks.picker.lazy()
      end,
      desc = "List lazy plugins",
    },
    {
      "<leader>vm",
      function()
        Snacks.picker.marks()
      end,
      desc = "List marks",
    },
    {
      "<leader>vp",
      function()
        Snacks.picker.pickers()
      end,
      desc = "List pickers",
    },
    {
      "<leader>vr",
      function()
        Snacks.picker.registers()
      end,
      desc = "List registers",
    },
    {
      "<leader>vs",
      function()
        Snacks.picker.spelling()
      end,
      desc = "List spelling",
    },

    {
      "<leader>vhc",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command history",
    },
    {
      "<leader>vhs",
      function()
        Snacks.picker.search_history()
      end,
      desc = "Search history",
    },
    {
      "<leader>vhu",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo history",
    },
    -- FIX(snacks): cliphist not installed
    -- {
    --   "<leader>vhy",
    --   function()
    --     Snacks.picker.cliphist()
    --   end,
    --   desc = "Yank history",
    -- },

    {
      "<leader>tl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "Show location list",
    },
    {
      "<leader>tq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Show quickfix list",
    },

    {
      "<leader>gff",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find git file",
    },
    {
      "<leader>gfb",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Find branch",
    },
    {
      "<leader>gfs",
      function()
        Snacks.picker.git_stash()
      end,
      desc = "Show stash",
    },
    {
      "<leader>gfc",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Find commit",
    },
    {
      "<leader>gfC",
      function()
        Snacks.picker.git_log_file()
      end,
      desc = "Find buffer commit",
    },
    {
      "<leader>gfl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Show log",
    },
    {
      "<leader>gfL",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Show buffer log",
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Show status",
    },
    {
      "<leader>gS",
      function()
        Snacks.picker.git_diff()
      end,
      desc = "Show diff",
    },
    {
      "<leader>go",
      function()
        Snacks.gitbrowse.open()
      end,
      desc = "Open repo",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit.open()
      end,
      desc = "Open lazygit",
    },

    {
      "<leader>nn",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Show notifications",
    },
    {
      "<leader>nh",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Show history",
    },
    {
      "<leader>nd",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss all notifications",
    },

    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next reference",
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Previous reference",
    },

    {
      "<leader>oe",
      function()
        Snacks.picker.explorer()
      end,
      desc = "Open explorer",
    },

    {
      "<leader>od",
      function()
        Snacks.dashboard.open()
      end,
      desc = "Open dashboard",
    },

    {
      "grN",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename file",
    },

    {
      "<leader>ua",
      function()
        vim.g.snacks_animate = not vim.g.snacks_animate
      end,
      desc = "Toggle animate",
    },
    {
      "<leader>ud",
      function()
        if Snacks.dim.enabled then
          Snacks.dim.disable()
        else
          Snacks.dim.enable()
        end
      end,
      desc = "Toggle dim",
    },
    {
      "<leader>uz",
      function()
        Snacks.zen.zen()
      end,
      desc = "Toggle zen",
    },
  },
  init = function()
    vim.g.snacks_animate = false

    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      desc = "Oil: rename file on move",
      callback = function(args)
        if args.data.actions.type == "move" then
          Snacks.rename.on_rename_file(args.data.actions.src_url, args.data.actions.dest_url)
        end
      end,
    })

    if config_plugins.vim.notify.snacks and config_plugins.lsp_notification.snacks then
      lsp_notification()
    end
  end,
  opts = {
    dashboard = require("plugins.snacks.dashboard"),
    picker = require("plugins.snacks.picker"),
    styles = {
      dashboard = {
        wo = {
          foldmethod = "marker",
        },
      },
      notification = {
        border = ui_style.border.default,
        wo = {
          winblend = 0,
          wrap = true,
          foldcolumn = "0",
        },
      },
      notification_history = {
        border = ui_style.border.default,
        width = 0.8,
        height = 0.8,
        minimal = true,
        title = " Notification History ",
        wo = {
          winblend = 0,
          wrap = true,
          foldcolumn = "0",
        },
        keys = {
          q = "close",
          ["<Esc>"] = "close",
        },
      },
      input = {
        title_pos = "left",
        relative = "cursor",
        width = 40,
        row = -3,
        col = -2,
        b = { completion = true },
        keys = {
          cr = { "<cr>", { "confirm" }, mode = { "i", "n" } },
          ctrl_c = "cancel",
          esc = "cancel",
          q = "cancel",

          i_cr = false,
          n_cr = false,
          i_tab = false,
          i_ctrl_w = false,
          i_up = false,
          i_down = false,
        },
      },
      zen = {
        enter = true,
        fixbuf = false,
        minimal = false,
        width = 120,
        height = 0,
        backdrop = true,
        keys = { q = false },
        zindex = 40,
        wo = {
          winhighlight = "NormalFloat:Normal",
        },
        w = {
          snacks_main = true,
        },
      },
    },

    input = {
      enabled = config_plugins.vim.ui.input.snacks,
      icon_pos = false,
      prompt_pos = "title",
    },

    statuscolumn = {
      left = { "fold", "git" },
      right = { "sign", "mark" },
      folds = {
        open = true,
        git_hl = true,
      },
    },

    notifier = {
      enabled = config_plugins.vim.notify.snacks,
      timeout = 5000,
      style = "compact", --- @type `"minimal"|"compact"|"fancy"`
      margin = {
        top = 4,
        right = 1,
        bottom = 1,
      },
      icons = {
        error = ui_icons.diagnostics.error,
        warn = ui_icons.diagnostics.warn,
        info = ui_icons.diagnostics.info,
        debug = ui_icons.diagnostics.debug,
        trace = ui_icons.diagnostics.trace,
      },
    },

    scroll = {
      animate = {
        duration = {
          step = 10,
          total = 100,
        },
      },
      animate_repeat = {
        delay = 50,
        duration = {
          step = 5,
          total = 50,
        },
      },
    },

    scope = {
      treesitter = {
        blocks = {
          enabled = true,
        },
      },
    },

    indent = {
      enabled = config_plugins.indent.snacks,
      animate = {
        enabled = true,
      },
      scope = {
        underline = true,
        hl = ui_highlights.rainbow,
      },
    },

    dim = {
      scope = {
        min_size = 5,
        max_size = 30,
      },
      animate = {
        duration = {
          step = 20,
          total = 200,
        },
      },
    },

    zen = {
      toggles = {
        dim = true,
        git_signs = false,
        mini_diff_signs = false,
        diagnostics = false,
        inlay_hints = false,
      },
      show = {
        statusline = false,
        tabline = false,
      },
      win = {
        style = "zen",
      },
    },

    lazygit = {
      configure = true,
      win = {
        width = 0,
        height = 0,
      },
    },

    gitbrowse = {
      url_patterns = {
        ["codeberg%.org"] = {
          branch = "/src/branch/{branch}",
          file = "/src/branch/{branch}/{file}",
          permalink = "/src/{commit}/{file}#L{line_start}-L{line_end}",
          commit = "/commit/{commit}",
        },
      },
    },

    animate = { enabled = true },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    explorer = { enabled = require("config.plugins").explorer.snacks },
    image = { enabled = true },
    quickfile = { enabled = true },
    toggle = { enabled = true },
    words = { enabled = true },
  },
}
