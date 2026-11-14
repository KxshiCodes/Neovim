return {
  "kawre/neotab.nvim",
  event = {
    "InsertEnter",
  },
  opts = {
    pairs = {
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      { open = "{", close = "}" },
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "<", close = ">" },
    },
    exclude = {},
    smart_punctuators = {
      enabled = true,
      semicolon = {
        enabled = true,
        ft = {
          "c",
          "cpp",
          "rust",
        },
      },
      escape = {
        enabled = false,
        triggers = {},
      },
    },
  },
}
