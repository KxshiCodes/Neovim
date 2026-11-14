local config = {
  vim = {
    ui = {
      -- BUG(snacks): renames `foo` instead of `bar` in `foo.bar` when cursor is at `b`
      input = "dressing", ---@type 'snacks' | 'dressing'
      -- BUG(snacks): crashes on require("luasnip.extras.select_choice")()
      select = "snacks", ---@type 'snacks' | 'dressing'
    },
    notify = "snacks", ---@type 'snacks' | 'fidget'
  },
  explorer = "oil", ---@type 'snacks' | 'oil'
  indent = "blink_indent", ---@type 'blink_indent' | 'snacks'
  pairs = "blink_pairs", ---@type  'blink_pairs' |'nvim_autopairs'| 'rainbow_delimiters'
  lsp_notification = "fidget", ---@type 'snacks' | 'fidget'
}

local M = {}

M.vim = {
  ui = {
    input = {
      snacks = config.vim.ui.input == "snacks",
      dressing = config.vim.ui.input == "dressing",
    },
    select = {
      snacks = config.vim.ui.select == "snacks",
      dressing = config.vim.ui.select == "dressing",
    },
  },
  notify = {
    snacks = config.vim.notify == "snacks",
    fidget = config.vim.notify == "fidget",
  },
}

M.explorer = {
  snacks = config.explorer == "snacks",
  oil = config.explorer == "oil",
}

M.indent = {
  blink_indent = config.indent == "blink_indent",
  snacks = config.indent == "snacks",
}

M.pairs = {
  blink_pairs = config.pairs == "blink_pairs",
  nvim_autopairs = config.pairs == "nvim_autopairs",
  rainbow_delimiters = config.pairs == "rainbow_delimiters",
}

M.lsp_notification = {
  snacks = config.lsp_notification == "snakcs",
  fidget = config.lsp_notification == "fidget",
}

M.dap = {
  enable = false,
}

return M
