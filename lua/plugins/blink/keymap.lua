return {
  preset = "none",

  ["<C-c>"] = { "cancel" },

  ["<C-y>"] = { "select_and_accept" },

  ["<C-p>"] = {
    "select_prev",
    function()
      local ls = require("luasnip")
      if ls.choice_active() then
        ls.change_choice(-1)
      end
    end,
    "fallback_to_mappings",
  },
  ["<C-n>"] = {
    "select_next",
    function()
      local ls = require("luasnip")
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end,
    "fallback_to_mappings",
  },

  ["<PageUp>"] = { "scroll_documentation_up", "fallback" },
  ["<PageDown>"] = { "scroll_documentation_down", "fallback" },
  ["<C-u>"] = { "scroll_documentation_up", "fallback" },
  ["<C-d>"] = { "scroll_documentation_down", "fallback" },
  ["<C-b>"] = { "scroll_documentation_up", "fallback" },
  ["<C-f>"] = { "scroll_documentation_down", "fallback" },

  ["<C-space>"] = { "show_documentation", "hide_documentation", "fallback" },
  ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },

  ["<C-k>"] = { "snippet_forward", "fallback" },
  ["<C-j>"] = { "snippet_backward", "fallback" },

  -- BUG(snacks): vim.ui.select crashes
  ["<C-e>"] = {
    function(_cmp)
      local ls = require("luasnip")
      if ls.choice_active() then
        require("luasnip.extras.select_choice")()
      end
    end,
  },
}
