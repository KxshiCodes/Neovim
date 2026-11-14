local ui_icons = require("ui.icons")

vim.g.mapleader = " "
vim.g.maplocalleader = vim.g.mapleader .. vim.g.mapleader

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins" },
}, {
  defaults = {
    lazy = true,
    version = "*",
  },
  install = { missing = true, colorscheme = { "tokyonight" } },
  checker = {
    enabled = true,
    check_pinned = false,
    notify = false,
    frequency = 86400, -- check every 24 hours
  },
  change_detection = { enabled = true, notify = false },
  performance = {
    cache = { enabled = true },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrw",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
    size = { width = 0.8, height = 0.8 },
    pills = true,
    icons = {
      source = "󰖟 ",
      runtime = " ",
      lazy = ui_icons.ui.sleep,
      cmd = "󰘳 ",
      event = "󱐋 ",
      ft = ui_icons.documents.file.regular,
      keys = "󰌌 ",
      init = ui_icons.ui.gear,
      config = ui_icons.ui.gear,
      loaded = ui_icons.shape.circle.check,
      not_loaded = ui_icons.shape.circle.dot,
      import = "󰋺 ",
      plugin = "󰏗 ",
      require = "󱧕 ",
      start = " ",
      task = ui_icons.ui.check,
      list = { " ", " ", " ", " ", " ", "󰅂 ", "󰄾 ", "󰶻 ", "", "󰧟 " },
    },
  },
})
