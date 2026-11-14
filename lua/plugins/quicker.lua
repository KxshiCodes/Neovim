local ui_icons = require("ui.icons")

return {
  "stevearc/quicker.nvim",
  ft = {
    "qf",
  },
  keys = {
    {
      "<leader>tQ",
      function()
        require("quicker").open({
          focus = true,
          min_height = 20,
          max_height = 40,
        })
      end,
      desc = "Open quickfix",
    },
    {
      "<leader>tL",
      function()
        require("quicker").open({
          loclist = true,
          focus = true,
          min_height = 20,
          max_height = 40,
        })
      end,
      desc = "Open loclist",
    },
  },
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    use_default_opts = false,
    opts = {
      buflisted = false,
      number = true,
      relativenumber = true,
      signcolumn = "auto",
      winfixheight = true,
      wrap = false,
    },

    keys = {
      {
        "q",
        function()
          require("quicker").close()
        end,
        desc = "Close quickfix",
      },

      {
        ">",
        function()
          require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = "Expand quickfix context",
      },
      {
        "<",
        function()
          require("quicker").collapse()
        end,
        desc = "Collapse quickfix context",
      },

      {
        "+",
        function()
          require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = "Expand quickfix context",
      },
      {
        "-",
        function()
          require("quicker").collapse()
        end,
        desc = "Collapse quickfix context",
      },
    },

    highlight = {
      treesitter = true,
      lsp = true,
      load_buffers = true,
    },
    follow = {
      enabled = true,
    },

    type_icons = {
      E = ui_icons.diagnostics.error,
      W = ui_icons.diagnostics.warn,
      I = ui_icons.diagnostics.info,
      N = ui_icons.diagnostics.info,
      H = ui_icons.diagnostics.hint,
    },

    max_filename_width = function()
      return math.floor(math.min(60, vim.o.columns / 2))
    end,
    header_length = function(type, start_col)
      return vim.o.columns - start_col
    end,
  },
}
