return {
  "mason-org/mason-lspconfig.nvim",
  version = "^2",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mason-org/mason.nvim",
  },
  cmd = {
    "LspInstall",
    "LspUninstall",
  },
  opts = {
    automatic_enable = {
      exclude = {
        "rust_analyzer",
      },
    },
  },
}
