local ui_style = require("ui.style")

return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>oo",
      function()
        require("oil").open_float()
      end,
      desc = "Open Oil",
    },
  },
  opts = {
    default_file_explorer = require("config.plugins").explorer.oil,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    watch_for_changes = true,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
      ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
      ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["q"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = "change directory to the current oil directory" },
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
    },
    float = {
      border = ui_style.border.default,
      max_width = 0.5,
      max_height = 0.5,
    },
    view_options = {
      show_hidden = true,
      natural_order = true,
      case_insensitive = true,
      is_always_hidden = function(name, _buffer)
        return name == ".." or name == ".git"
      end,
    },
    win_options = {
      wrap = true,
    },
  },
}
