local ui_icons = require("ui.icons")
local ui_style = require("ui.style")

vim.diagnostic.config({
  update_in_insert = false,
  severity_sort = true,
  signs = {
    severity = { min = vim.diagnostic.severity.HINT },
    text = {
      [vim.diagnostic.severity.ERROR] = ui_icons.diagnostics.error,
      [vim.diagnostic.severity.WARN] = ui_icons.diagnostics.warn,
      [vim.diagnostic.severity.INFO] = ui_icons.diagnostics.info,
      [vim.diagnostic.severity.HINT] = ui_icons.diagnostics.hint,
    },
  },
  virtual_text = false,
  virtual_lines = {
    severity = { min = vim.diagnostic.severity.WARN },
    current_line = true,
  },
  underline = {
    severity = { min = vim.diagnostic.severity.HINT },
  },
  float = ui_style.floating_window.config({
    source = true, ---@type `bool|"if_many"`
    header = "", ---@type `string|{string, hl_group}`
    prefix = "", ---@type `string|table|(fun(diagnostic, i, total): string, string)`
    suffix = "", ---@type `string|table|(fun(diagnostic, i, total): string, string)`
  }),
})

vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("diagnostics_on_attach", { clear = true }),
  desc = "Diagnostics: keymaps",
  callback = function(args)
    local buffer = args.buf

    local keys = {
      {
        mode = { "n" },
        buffer = buffer,
        {
          mode = { "n" },
          buffer = buffer,
          {
            "gk",
            function()
              vim.diagnostic.open_float()
            end,
            desc = "Hover diagnostic",
          },
        },
        {
          "]d",
          function()
            vim.diagnostic.jump({ count = 1, float = true })
          end,
          desc = "Next diagnostic",
        },
        {
          "[d",
          function()
            vim.diagnostic.jump({ count = -1, float = true })
          end,
          desc = "Previous diagnostic",
        },
        {
          "]e",
          function()
            vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity["ERROR"] })
          end,
          desc = "Next error",
        },
        {
          "[e",
          function()
            vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity["ERROR"] })
          end,
          desc = "Previous error",
        },
        {
          "]w",
          function()
            vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity["WARN"] })
          end,
          desc = "Next warning",
        },
        {
          "[w",
          function()
            vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity["WARN"] })
          end,
          desc = "Previous warning",
        },

        { "<leader>td", Snacks.picker.diagnostics_buffer, desc = "Show buffer diagnostics" },
        { "<leader>tD", Snacks.picker.diagnostics, desc = "Show workspace diagnostic" },
      },
    }

    require("which-key").add(keys)
  end,
})
