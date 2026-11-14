return {
  "danymat/neogen",
  dependencies = {
    "neovim-treesitter/nvim-treesitter",
    "L3MON4D3/LuaSnip",
  },
  keys = {
    {
      "grg",
      function()
        require("neogen").generate()
      end,
      desc = "Generate annotation",
    },
  },
  opts = { snippet_engine = "luasnip" },
}
