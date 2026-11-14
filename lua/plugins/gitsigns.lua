local ui_icons = require("ui.icons")
local ui_style = require("ui.style")

local gitsigns_icons = {
  add = { text = ui_icons.tree.heavy.vertical },
  change = { text = ui_icons.tree.heavy.vertical },
  delete = { text = ui_icons.tree.caret.right },
  topdelete = { text = ui_icons.tree.caret.right },
  changedelete = { text = ui_icons.tree.heavy.vertical },
  untracked = { text = ui_icons.tree.heavy.triple_dash },
}

return {
  "lewis6991/gitsigns.nvim",
  cond = require("config.languages").is_enabled("git"),
  dependencies = {
    "folke/which-key.nvim",
  },
  event = {
    "BufRead",
  },
  opts = {
    signs = gitsigns_icons,
    signs_staged = gitsigns_icons,
    signs_staged_enable = true,
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    },
    current_line_blame_formatter = "    <author>: <summary> - <author_time:%H:%M on %d-%m-%Y>",
    preview_config = {
      border = ui_style.border.default,
      row = -2,
      col = 1,
    },
    on_attach = function(buffer)
      local gitsigns = require("gitsigns")

      local normal = {
        mode = { "n" },
        buffer = buffer,
        {
          "]g",
          function()
            gitsigns.nav_hunk("next", { navigation_message = false })
          end,
          desc = "Next git hunk",
        },
        {
          "[g",
          function()
            gitsigns.nav_hunk("prev", { navigation_message = false })
          end,
          desc = "Previous git hunk",
        },
        {
          "<leader>gb",
          function()
            gitsigns.blame_line({ full = true })
          end,
          desc = "Show blame line",
        },
        {
          "<leader>gD",
          function()
            gitsigns.diffthis()
          end,
          desc = "Open diff",
        },
        { "<leader>gh", group = "hunk" },
        {
          "<leader>ghs",
          function()
            gitsigns.stage_hunk()
            gitsigns.nav_hunk("next")
          end,
          desc = "Stage hunk",
        },
        {
          "<leader>ghS",
          function()
            gitsigns.stage_buffer()
          end,
          desc = "Stage buffer",
        },
        {
          "<leader>ghr",
          function()
            gitsigns.reset_hunk()
            gitsigns.nav_hunk("next")
          end,
          desc = "Reset hunk",
        },
        {
          "<leader>ghR",
          function()
            gitsigns.reset_buffer()
          end,
          desc = "Reset buffer",
        },
        {
          "<leader>ghh",
          function()
            gitsigns.select_hunk()
          end,
          desc = "Select hunk",
        },
        {
          "<leader>ghp",
          function()
            gitsigns.preview_hunk()
          end,
          desc = "Preview hunk",
        },
        {
          "<leader>ghi",
          function()
            gitsigns.preview_hunk_inline()
          end,
          desc = "Preview hunk inline",
        },
        { "<leader>gu", group = "ui" },
        {
          "<leader>gub",
          function()
            gitsigns.toggle_current_line_blame()
          end,
          desc = "Toggle blame line",
        },
        {
          "<leader>gul",
          function()
            gitsigns.toggle_linehl()
            ---@diagnostic disable-next-line: deprecated
            gitsigns.toggle_deleted()
          end,
          desc = "Toggle lines highlight",
        },
        {
          "<leader>gun",
          function()
            gitsigns.toggle_signs()
            gitsigns.toggle_numhl()
          end,
          desc = "Toggle number highlight",
        },
        {
          "<leader>guw",
          function()
            gitsigns.toggle_word_diff()
          end,
          desc = "Toggle word diff",
        },
      }

      local visual = {
        mode = { "x" },
        buffer = buffer,
        { "<leader>gh", group = "hunk" },
        {
          "<leader>ghs",
          function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            gitsigns.nav_hunk("next")
          end,
          desc = "Stage hunk",
        },
        {
          "<leader>ghr",
          function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            gitsigns.nav_hunk("next")
          end,
          desc = "Reset hunk",
        },
      }

      local operator = {
        mode = { "o", "x" },
        buffer = buffer,
        {
          "ih",
          function()
            gitsigns.select_hunk()
          end,
          desc = "inner git hunk",
        },
      }

      local keys = { normal, visual, operator }

      require("which-key").add(keys)
    end,
  },
}
