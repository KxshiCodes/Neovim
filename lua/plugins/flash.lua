local ui_filetypes = require("ui.filetypes")

return {
  "folke/flash.nvim",
  keys = {
    { "f" },
    { "F" },
    { "t" },
    { "T" },
    {
      "s",
      function()
        require("flash").jump()
      end,
      desc = "Flash",
      mode = { "n", "o", "x" },
    },
    {
      "S",
      function()
        require("flash").treesitter()
      end,
      desc = "Flash treesitter",
      mode = { "n", "o", "x" },
    },
    {
      "r",
      function()
        require("flash").remote()
      end,
      desc = "Remote flash",
      mode = { "o" },
    },
    {
      "R",
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter search",
      mode = { "o", "x" },
    },
    {
      "<C-s>",
      function()
        require("flash").toggle()
      end,
      desc = "Toggle flash search",
      mode = { "c" },
    },
  },
  opts = {
    -- colemak layout
    labels = "tnseriaodhplfugmcwyvkbjqxz",
    search = {
      multi_window = false,
      exclude = ui_filetypes.flash,
    },
    jump = {
      nohlsearch = true,
      autojump = true,
    },
    label = {
      uppercase = false,
    },
  },
}
