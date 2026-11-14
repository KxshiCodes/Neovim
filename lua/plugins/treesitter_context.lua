return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = {
    "neovim-treesitter/nvim-treesitter",
  },
  cmd = {
    "TSContext",
  },
  event = {
    "BufRead",
  },
  keys = {
    {
      "<leader>ut",
      "<cmd>TSContext toggle<cr>",
      desc = "Toggle treesitter context",
    },
    {
      "gT",
      function()
        require("treesitter-context").go_to_context()
      end,
      desc = "Go to treesitter context",
    },
  },
  opts = {},
}
