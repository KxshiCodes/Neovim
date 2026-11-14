local ui_filetypes = require("ui.filetypes")
local ui_icons = require("ui.icons")

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  init = function()
    vim.opt.laststatus = 3
    vim.opt.showmode = false
    vim.opt.showcmd = true
    vim.opt.showcmdloc = "statusline"
  end,
  opts = function()
    local lazy_status = require("lazy.status")

    local opts = {
      options = {
        theme = "tokyonight",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        always_divide_middle = false,
        globalstatus = true,
        disabled_filetypes = {
          statusline = ui_filetypes.lualine,
          winbar = {},
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            "branch",
            icon = "",
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true,
            newfile_status = true,
            path = 1,
            shorting_target = 40,
            symbols = {
              modified = ui_icons.documents.file.edit,
              readonly = ui_icons.ui.eye,
              unnamed = ui_icons.documents.file.outline,
              newfile = ui_icons.documents.file.plus,
            },
          },
          {
            "diff",
            colored = true,
            symbols = {
              added = ui_icons.shape.circle.plus,
              modified = ui_icons.shape.circle.dot,
              removed = ui_icons.shape.circle.minus,
            },
            source = nil,
          },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          {
            "diagnostics",
            colored = true,
            sources = { "nvim_lsp", "nvim_diagnostic" },
            sections = { "error", "warn", "hint", "info" },
            symbols = {
              error = ui_icons.diagnostics.error,
              warn = ui_icons.diagnostics.warn,
              info = ui_icons.diagnostics.info,
              hint = ui_icons.diagnostics.hint,
            },
            update_in_insert = false,
            always_visible = false,
          },
          {
            "filetype",
            colored = true,
            icon_only = false,
          },
        },
        lualine_y = {
          {
            "searchcount",
            maxcount = 999,
            timeout = 500,
          },
          { "selectioncount" },
          { "progress" },
        },
        lualine_z = {
          { "location" },
        },
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
    }

    return opts
  end,
}
