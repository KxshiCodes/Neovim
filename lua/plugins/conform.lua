local languages = require("config.languages")

return {
  "stevearc/conform.nvim",
  cmd = {
    "ConformInfo",
  },
  event = {
    "BufWritePre",
  },
  keys = {
    {
      "<leader>ic",
      "<cmd>ConformInfo<cr>",
      desc = "Show Conform info",
    },
    {
      "grf",
      function()
        require("conform").format({ async = true })
      end,
      desc = "Format file",
      mode = { "n" },
    },
    {
      "grf",
      function()
        require("conform").format({ async = true }, function(err)
          if not err then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
          end
        end)
      end,
      desc = "Format range",
      mode = { "x" },
    },
  },
  opts = function()
    local opts = {
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },
      formatters = {
        c_formatter_42 = require("custom-mason-registry.formatters.c_formatter_42"),
      },
      formatters_by_ft = languages.conform_formatters(),
    }

    return opts
  end,
}
