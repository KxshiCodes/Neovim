local ui_icons = require("ui.icons")

return {
  "kristijanhusak/vim-dadbod-ui",
  cond = require("config.languages").is_enabled("sql"),
  dependencies = {
    "folke/which-key.nvim",
    "tpope/vim-dadbod",
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = {
        "sql",
      },
    },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIClose",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    vim.g.db_ui_show_help = 0
    vim.g.db_ui_env_variable_url = "DATABASE_URL"
    vim.g.db_ui_env_variable_name = "DATABASE_NAME"
    vim.g.db_ui_use_nerd_fonts = 1

    -- TODO(icons): add icons to module
    vim.g.db_ui_icons = {
      expanded = ui_icons.tree.caret.down,
      collapsed = ui_icons.tree.caret.right,
      saved_query = " ",
      new_query = ui_icons.ui.search,
      tables = " ",
      buffers = " ",
      connection_ok = "󰪩 ",
      connection_error = "󰴀 ",
    }
  end,
  config = function()
    local buffer = vim.api.nvim_get_current_buf()
    local which_key = require("which-key")

    which_key.add({
      {
        mode = { "n" },
        buffer = buffer,
        { "<localleader>", group = "sql" },
        { "<localleader>o", "<cmd>DBUI<cr>", desc = "Open DBUI" },
        { "<localleader>q", "<cmd>DBUIClose<cr>", desc = "Close DBUI" },
        { "<localleader>t", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
      },
    })
  end,
}
