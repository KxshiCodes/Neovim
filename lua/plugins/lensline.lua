return {
  "oribarilan/lensline.nvim",
  branch = "release/2.x",
  event = {
    "LspAttach",
  },
  opts = {
    profiles = {
      {
        name = "default",
        providers = {
          {
            name = "usages",
            enabled = true,
            include = { "refs", "defs", "impls" },
            breakdown = true,
            show_zero = true,
            labels = {
              refs = "refs",
              impls = "impls",
              defs = "defs",
              usages = "usages",
            },
            icon_for_single = "󰌹 ",
            inner_separator = ", ",
          },
          {
            name = "diagnostics",
            enabled = true,
            min_level = "WARN",
          },
          {
            name = "complexity",
            enabled = true,
            min_level = "L",
          },
          {
            name = "function_length",
            enabled = true,
            event = {
              "BufWritePost",
              "TextChanged",
            },
            handler = function(buffer, func_info, _provider_configg, callback)
              local utils = require("lensline.utils")

              local function_lines = utils.get_function_lines(buffer, func_info)
              local func_line_count = math.max(0, #function_lines - 3)

              callback({
                line = func_info.line,
                text = string.format("(%d lines)", func_line_count),
              })
            end,
          },
        },
        style = {
          prefix = "",
          placement = "inline",
          ---@type "focused"|"all"
          render = "all",
          use_nerdfont = true,
        },
      },
    },
  },
}
