return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = {
    "BufRead",
  },
  init = function()
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = false,
    })
  end,
  opts = {
    ---@type "modern"|"classic"|"minimal"|"powerline"|"ghost"|"simple"|"nonerdfont"|"amongus"
    preset = "classic",
    transparent_bg = false,
    transparent_cursorline = false,
    disabled_ft = {},
    options = {
      show_source = {
        enabled = true,
      },
      use_icons_from_diagnostic = true,
      show_code = true,
      add_messages = {
        messages = true,
        display_count = false,
        use_max_severity = false,
        show_multiple_glyphs = true,
      },
      multilines = {
        enabled = true,
        always_show = true,
        trim_whitespaces = true,
      },
      show_all_diags_on_cursorline = true,
      show_diags_only_under_cursor = false,
    },
  },
}
