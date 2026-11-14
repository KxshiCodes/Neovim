return {
  "numToStr/Comment.nvim",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  event = {
    "BufRead",
  },
  opts = {
    padding = true,
    sticky = false,
    ignore = nil,
    toggler = {
      line = "gcc",
      block = "gbc",
    },
    opleader = {
      line = "gc", -- `gc[count]{motion}`
      block = "gb", -- `gb[count]{motion}`
    },
    extra = {
      above = "gcO",
      below = "gco",
      eol = "gcA",
    },
    mappings = {
      basic = true,
      extra = true,
    },
    pre_hook = function()
      require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
    end,
    post_hook = nil,
  },
  config = function(_, opts)
    local comment = require("Comment")
    local ft = require("Comment.ft")

    comment.setup(opts)

    ft.set("kdl", { "//%s", "/*%s*/" })
    ft.set("salt", { "#%s", "{#%s#}" })
  end,
}
