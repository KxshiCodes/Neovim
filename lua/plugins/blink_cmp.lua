local ui_filetypes = require("ui.filetypes")
local ui_style = require("ui.style")

-- https://cmp.saghen.dev

return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    {
      "saghen/blink.compat",
      opts = {
        impersonate_nvim_cmp = false,
      },
    },
    "rafamadriz/friendly-snippets",
    "L3MON4D3/LuaSnip",
    "nvim-tree/nvim-web-devicons",
    "onsails/lspkind.nvim",
    {
      "xzbdmw/colorful-menu.nvim",
      opts = {},
    },
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = {
        "sql",
      },
    },
    "folke/lazydev.nvim",
    {
      "Kaiser-Yang/blink-cmp-git",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
    "MahanRahmati/blink-nerdfont.nvim",
    "becknik/blink-cmp-luasnip-choice",
    "mikavilpas/blink-ripgrep.nvim",
  },
  event = {
    "BufRead",
    "InsertEnter",
    "CmdlineEnter",
  },
  opts_extend = {
    "sources.default",
    "sources.compat",
  },
  opts = function()
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    local opts = {}

    opts.enabled = function()
      return not vim.list_contains(ui_filetypes.blink, vim.bo.filetype)
    end

    opts.snippets = {
      preset = "luasnip",
    }

    opts.completion = require("plugins.blink.completion")
    opts.sources = require("plugins.blink.sources")
    opts.keymap = require("plugins.blink.keymap")
    opts.cmdline = require("plugins.blink.cmdline")

    opts.signature = {
      enabled = true,
      trigger = {
        show_on_keyword = true,
        show_on_insert = true,
      },
      window = {
        min_width = 20,
        max_width = ui_style.floating_window.max_width,
        max_height = ui_style.floating_window.max_height,
        border = ui_style.border.padded,
        scrollbar = true,
        treesitter_highlighting = true,
        show_documentation = true,
      },
    }

    opts.fuzzy = {
      implementation = "prefer_rust_with_warning",
      sorts = {
        "exact",
        "score",
        "sort_text",
        "kind",
        "label",
      },
    }

    return opts
  end,
}
