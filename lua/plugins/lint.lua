local languages = require("config.languages")

return {
  "mfussenegger/nvim-lint",
  init = function()
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("nvim_lint_auto_lint", { clear = true }),
      desc = "Auto lint",
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
  config = function()
    local lint = require("lint")

    lint.linters.norminette = require("custom-mason-registry.linters.norminette")

    lint.linters.selene.args = {
      "--config",
      vim.fn.stdpath("config") .. "/selene.toml",
      unpack(lint.linters.selene.args),
    }

    lint.linters_by_ft = languages.lint_linters()
  end,
}
