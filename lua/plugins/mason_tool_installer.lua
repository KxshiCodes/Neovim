local languages = require("config.languages")

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  lazy = false,
  cmd = {
    "MasonToolsInstall",
    "MasonToolsInstallSync",
    "MasonToolsUpdate",
    "MasonToolsUpdateSync",
    "MasonToolsClean",
  },
  opts = function()
    local opts = {
      ensure_installed = languages.mason_tools(),
      auto_update = true,
      run_on_start = true,
    }

    return opts
  end,
}
