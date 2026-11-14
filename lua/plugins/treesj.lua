return {
  "Wansmer/treesj",
  dependencies = {
    "neovim-treesitter/nvim-treesitter",
  },
  cmd = {
    "TSJToggle",
    "TSJSplit",
    "TSJJoin",
  },
  event = {
    "BufRead",
  },
  keys = {
    {
      "grbs",
      function()
        require("treesj").split()
      end,
      desc = "Split code block",
    },
    {
      "grbj",
      function()
        require("treesj").join()
      end,
      desc = "Join code block",
    },
    {
      "grbb",
      function()
        require("treesj").toggle()
      end,
      desc = "Toggle code block",
    },
    {
      "grbr",
      function()
        require("treesj").toggle({ split = { recursive = true } })
      end,
      desc = "Toggle code block recursively",
    },
  },
  opts = {
    use_default_keymaps = false,
  },
}
