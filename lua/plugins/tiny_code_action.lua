local ui_icons = require("ui.icons")

return {
  "rachartier/tiny-code-action.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
  },
  event = {
    "LspAttach",
  },
  keys = {
    {
      "gra",
      function()
        require("tiny-code-action").code_action({})
      end,
      desc = "Code action (preview)",
      mode = { "n", "x" },
    },
    {
      "grp",
      function()
        require("tiny-code-action").code_action({
          filter = function(action, client)
            local client_name = client and client.name or "unknown client"
            local kind = action and action.kind or "unknown action kind"
            local title = action and action.title or "unknown action title"
            vim.notify(client_name .. ": " .. kind .. ": " .. title, vim.log.levels.DEBUG, {
              id = "code actions info",
              title = "tiny-code-action.nvim",
            })
          end,
        })
      end,
      desc = "Print code actions",
      mode = { "n", "x" },
    },
  },
  opts = {
    ---@type "telescope"|"snacks"|"select"|"buffer"|"fzf-lua"
    picker = "snacks",
    ---@type "vim"|"delta"|"difftastic"|"diffsofancy"
    backend = "delta",
    backend_opts = {
      delta = {
        header_lines_to_remove = 4,
        args = {},
      },
    },
    signs = {
      refactor = { ui_icons.ui.scissors, { link = "TodoCommentWarn" } },
      ["refactor.extract"] = { ui_icons.ui.tool, { link = "TodoCommentWarn" } },
      ["refactor.move"] = { ui_icons.documents.file.move, { link = "TodoCommentWarn" } },
      source = { ui_icons.ui.code, { link = "TodoCommentInfo" } },
      ["source.fixAll"] = { ui_icons.ui.broom, { link = "TodoCommentError" } },
      ["source.organizeImports"] = { ui_icons.documents.folder.menu, { link = "TodoCommentWarn" } },
      rename = { ui_icons.shape.square.pen, { link = "TodoCommentWarn" } },
      quickfix = { ui_icons.ui.sparkles, { link = "TodoCommentInfo" } },
      codeAction = { ui_icons.diagnostics.hint, { link = "TodoCommentHint" } },
      others = { ui_icons.diagnostics.hint, { link = "TodoCommentHint" } },
    },
  },
}
