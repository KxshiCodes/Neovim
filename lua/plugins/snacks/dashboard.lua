local ui_icons = require("ui.icons")

-- https://github.com/MaximilianLloyd/ascii.nvim/blob/master/lua/ascii/text/neovim.lua
local logo = [[
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████]]

return {
  enabled = true,
  width = 80,
  pane_gap = 4,
  autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
  preset = {
    header = logo,
    keys = {
      {
        icon = ui_icons.documents.file.plus,
        key = "n",
        desc = "New file",
        action = "<cmd>ene | startinsert<cr>",
      },
      {
        icon = ui_icons.documents.file.regular,
        key = "f",
        desc = "Find file",
        action = function()
          Snacks.picker.files()
        end,
      },
      {
        icon = ui_icons.ui.clock,
        key = "r",
        desc = "Recent file",
        action = function()
          Snacks.picker.recent()
        end,
      },
      {
        icon = ui_icons.ui.search,
        key = "/",
        desc = "Grep",
        action = function()
          Snacks.picker.grep()
        end,
      },
      {
        icon = ui_icons.ui.gear,
        key = "c",
        desc = "Config",
        action = function()
          local configs = {}
          local config = vim.fn.stdpath("config")

          if type(config) == "string" then
            configs = { config }
          else
            configs = config
          end

          Snacks.picker.files({ dirs = configs })
        end,
      },
      {
        icon = ui_icons.ui.sleep,
        key = "L",
        desc = "Lazy",
        action = "<cmd>Lazy<cr>",
        enabled = package.loaded.lazy ~= nil,
      },
      {
        icon = ui_icons.ui.tool,
        key = "M",
        desc = "Mason",
        action = "<cmd>Mason<cr>",
        enabled = package.loaded.lazy ~= nil,
      },
      {
        icon = " ",
        key = "q",
        desc = "Quit",
        action = "<cmd>qa<cr>",
      },
    },
  },
  sections = {
    {
      pane = 1,
      section = "header",
      align = "center",
    },
    {
      pane = 1,
      icon = "󰌌 ",
      title = "Keymaps",
      section = "keys",
      indent = 2,
      padding = 1,
    },
    {
      pane = 1,
      icon = ui_icons.documents.file.regular,
      title = "Recent Files",
      section = "recent_files",
      cwd = true,
      indent = 2,
      padding = 1,
    },
    {
      pane = 1,
      icon = ui_icons.documents.folder.open,
      title = "Projects",
      section = "projects",
      indent = 2,
      padding = 1,
    },
    {
      pane = 1,
      section = "startup",
      align = "center",
      padding = 1,
    },
  },
}
