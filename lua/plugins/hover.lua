local ui_style = require("ui.style")

return {
  "lewis6991/hover.nvim",
  opts = {
    providers = {
      "hover.providers.diagnostic",
      "hover.providers.lsp",
      -- 'hover.providers.dap',
      "hover.providers.man",
      "hover.providers.dictionary",
      -- 'hover.providers.gh',
      -- 'hover.providers.gh_user',
      -- 'hover.providers.jira',
      -- 'hover.providers.fold_preview',
      -- 'hover.providers.highlight',
    },
    preview_opts = ui_style.floating_window.config(),
    preview_window = true,
    title = true,
  },
}
