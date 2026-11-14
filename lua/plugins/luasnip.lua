return {
  "L3MON4D3/LuaSnip",
  version = "^2",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  opts = {
    keep_roots = true,
    link_roots = true,
    link_children = true,
    exit_roots = false,
    update_events = { "InsertLeave", "TextChanged", "TextChangedI" },
    delete_check_events = { "TextChanged" },
    enable_autosnippets = false,
  },
  config = function(_, opts)
    local luasnip = require("luasnip")
    local loaders = require("luasnip.loaders.from_lua")

    luasnip.config.setup(opts)

    loaders.load({
      paths = {
        vim.fn.stdpath("config") .. "/snippets/",
      },
    })
  end,
}
