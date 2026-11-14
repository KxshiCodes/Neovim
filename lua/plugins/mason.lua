local ui_icons = require("ui.icons")
local ui_style = require("ui.style")

return {
  "mason-org/mason.nvim",
  version = "^2",
  cmd = {
    "Mason",
    "MasonUpdate",
    "MasonInstall",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
  },
  keys = {
    {
      "<leader>om",
      "<cmd>Mason<cr>",
      desc = "Open Mason",
    },
  },
  opts = {
    max_concurrent_installers = 4,
    registries = {
      "lua:custom-mason-registry",
      "github:mason-org/mason-registry",
    },
    ui = {
      border = ui_style.border.default,
      width = 0.8,
      height = 0.8,
      icons = {
        package_installed = ui_icons.shape.circle.check,
        package_pending = ui_icons.ui.download,
        package_uninstalled = ui_icons.shape.circle.outline,
      },
      keymaps = {
        toggle_package_expand = "<cr>",
        toggle_package_install_log = "<cr>",
        install_package = "i",
        update_package = "u",
        update_all_packages = "U",
        check_package_version = "c",
        check_outdated_packages = "C",
        uninstall_package = "x",
        cancel_installation = "<c-c>",
        apply_language_filter = "<c-l>",
        toggle_help = "?",
      },
    },
  },
}
