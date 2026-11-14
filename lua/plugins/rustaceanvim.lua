local ui_style = require("ui.style")

return {
  "mrcjkb/rustaceanvim",
  cond = require("config.languages").is_enabled("rust"),
  version = "^7",
  lazy = false,
  init = function()
    vim.g.rustaceanvim = {
      tools = {
        code_actions = {
          ui_select_fallback = false,
          keys = {
            confirm = { "<CR>" },
            quit = { "q", "<Esc>", "<C-c>" },
          },
        },
        float_win_config = ui_style.floating_window.config(),
      },
      server = {
        -- https://rust-analyzer.github.io/book/configuration.html
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              features = { "all" },
            },
            check = {
              command = "clippy",
            },
            diagnostics = {
              styleLints = { enable = true },
              disabled = { "inactive-code", "unresolved-proc-macro" },
            },
            procMacro = {
              ignored = {
                ["async-recursion"] = { "async_recursion" },
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
              },
            },
            rustfmt = { extraArgs = { "+nightly" } },
          },
        },
      },
    }
  end,
}
