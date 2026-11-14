return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "mason-org/mason.nvim",
  },
  event = {
    "BufRead",
  },
  opts = {},
  config = function(_, opts)
    local null_ls = require("null-ls")

    null_ls.setup(opts)

    local open_rule_documentation = {
      name = "Open rule documentation",
      method = require("null-ls").methods.CODE_ACTION,
      filetypes = { "python" },
      generator = {
        fn = function(params)
          local code_actions = {}

          local diagnostics = vim.diagnostic.get(params.bufnr, {
            lnum = params.lsp_params.range.start.line,
          })

          for _, diagnostic in ipairs(diagnostics) do
            if diagnostic.source:lower() == "ruff" and diagnostic.code then
              table.insert(code_actions, {
                title = "Ruff (" .. diagnostic.code .. "): Open documentation",
                action = function()
                  local url = "https://docs.astral.sh/ruff/rules/" .. diagnostic.code
                  vim.fn.jobstart({ "xdg-open", url }, { detach = true })
                end,
              })
            end
          end

          return code_actions
        end,
      },
    }

    null_ls.register(open_rule_documentation)
  end,
}
