return {
  "NeogitOrg/neogit",
  cond = require("config.languages").is_enabled("git"),
  tag = "v3.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
  },
  cmd = {
    "Neogit",
    "NeogitResetState",
  },
  keys = {
    {
      "<leader>gn",
      function()
        require("neogit").open()
      end,
      desc = "Open Neogit",
    },
    {
      "<leader>gc",
      function()
        require("neogit").open({ "commit" })
      end,
      desc = "Commit with Neogit",
    },
  },
  opts = {
    disable_hint = true,
    disable_context_highlighting = false,
    disable_signs = true,
    disable_insert_on_commit = "auto",
    process_spinner = false,
    graph_style = "unicode", --- @type `"ascii"|"unicode"|"kitty"`
    integrations = {
      telescope = false,
      diffview = false,
      fzf_lua = false,
      mini_pick = false,
      snacks = true,
    },
    sections = {
      sequencer = { folded = false, hidden = false }, -- Default: false, false
      untracked = { folded = false, hidden = false }, -- Default: false, false
      unstaged = { folded = false, hidden = false }, -- Default: false, false
      stashes = { folded = false, hidden = false }, -- Default: true, false
      unpulled_upstream = { folded = false, hidden = false }, -- Default: true, false
      unmerged_upstream = { folded = false, hidden = false }, -- Default: true, false
      unpulled_pushRemote = { folded = false, hidden = false }, -- Default: true, false
      unmerged_pushRemote = { folded = false, hidden = false }, -- Default: true, false
      recent = { folded = false, hidden = false }, -- Default: true, false
    },
  },
}
