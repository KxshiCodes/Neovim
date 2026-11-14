local ui_filetypes = require("ui.filetypes")
local ui_icons = require("ui.icons")

return {
  "folke/todo-comments.nvim",
  -- NOTE(snacks): snacks source was implemented after v1.4.0
  version = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = {
    "TodoQuixFix",
    "TodoLocList",
  },
  event = {
    "BufRead",
  },
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next todo comment",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous todo comment",
    },
    {
      "<leader>tt",
      function()
        Snacks.picker.pick("todo_comments")
      end,
      desc = "Find todo",
    },
  },
  opts = {
    keywords = {
      -- ERROR: error fix fixme fixit bug
      -- WARN: warn warning hack
      -- INFO: info
      -- HINT: hint
      -- TODO: todo
      -- NOTE: note
      -- TEST: test testing passed failed
      -- PERF: perf performance optim optimize
      --
      -- ERROR(scope): error fix fixme fixit bug
      -- WARN(scope): warn warning hack
      -- INFO(): info
      -- HINT(): hint
      -- TODO(user): todo
      -- NOTE(): note
      -- TEST(later): test testing passed failed
      -- PERF(later): perf performance optim optimize

      ERROR = { icon = ui_icons.ui.bug, color = "error", alt = { "FIX", "FIXME", "BUG" } },
      WARN = { icon = ui_icons.diagnostics.warn, color = "warning", alt = { "WARNING", "HACK" } },
      INFO = { icon = ui_icons.diagnostics.info, color = "info", alt = {} },
      HINT = { icon = ui_icons.diagnostics.hint, color = "hint", alt = {} },
      TODO = { icon = ui_icons.ui.todo, color = "todo", alt = {} },
      NOTE = { icon = ui_icons.ui.note, color = "note", alt = {} },
      TEST = { icon = ui_icons.ui.test, color = "test", alt = { "PASSED", "FAILED" } },
      PERF = { icon = ui_icons.ui.clock, color = "perf", alt = { "PERFORMANCE", "OPTIM", "OPTIMIZE" } },
    },
    highlight = {
      before = "", -- "fg" or "bg" or empty
      keyword = "bg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty.
      after = "fg", -- "fg" or "bg" or empty
      -- vim regex
      -- default: [[.*<(KEYWORDS)\s*:]]
      pattern = {
        [[.*<(KEYWORDS):]],
        [[.*<(KEYWORDS)\(.*\):]],
      },
      exclude = ui_filetypes.all,
    },
    colors = {
      error = { "TodoCommentError", "DiagnosticError", "ErrorMsg", "#de5858" },
      warning = { "TodoCommentWarn", "DiagnosticWarn", "WarningMsg", "#e0af68" },
      info = { "TodoCommentInfo", "DiagnosticInfo", "#0db9d7" },
      hint = { "TodoCommentHint", "DiagnosticHint", "#1abc9c" },
      todo = { "TodoCommentTodo", "Identifier", "#7aa2f7" },
      note = { "TodoCommentNote", "Identifier", "#41a6b5" },
      test = { "TodoCommentTest", "Identifier", "#bb9af7" },
      perf = { "TodoCommentPerf", "Identifier", "#9d7cd8" },
      default = { "TodoCommentDefault", "Identifier", "#9d7cd8" },
    },
    search = {
      -- ripgrep regex
      -- default: [[\b(KEYWORDS):]]
      pattern = [[\b(KEYWORDS)(\(.*\))?:]],
    },
  },
}
