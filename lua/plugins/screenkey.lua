local ui_style = require("ui.style")

return {
  "NStefan002/screenkey.nvim",
  keys = {
    {
      "<leader>us",
      function()
        require("screenkey").toggle()
      end,
      desc = "Toggle screenkey",
    },
  },
  opts = function()
    local width = 40
    local height = 3

    local row = vim.o.lines - vim.o.cmdheight - 1
    local col = (vim.o.columns - width) / 2

    local opts = {
      win_opts = {
        width = width,
        height = height,
        anchor = "SW",
        row = row,
        col = col,
        border = ui_style.border.default,
        style = "minimal",
      },
      show_leader = true,
      group_mappings = true,
    }

    return opts
  end,
}
