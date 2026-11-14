local config_plugins = require("config.plugins")
local ui_filetypes = require("ui.filetypes")
local ui_highlights = require("ui.highlights")

return {
  "saghen/blink.pairs",
  enabled = config_plugins.pairs.blink_pairs,
  version = "0.5",
  dependencies = {
    "saghen/blink.download",
  },
  event = {
    "BufRead",
  },
  --- @module 'blink.pairs'
  --- @return blink.pairs.Config
  opts = function()
    -- NOTE(pairs): don't add pair if next character is alphanumeric
    -- - https://github.com/windwp/nvim-autopairs?tab=readme-ov-file#dont-add-pairs-if-the-next-char-is-alphanumeric
    -- - https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L52

    local default_pairs = require("blink.pairs.config.mappings").default.pairs

    local custom_pairs = {
      ["("] = {
        {
          "(",
          ")",
          when = function(ctx)
            -- ignore alphanumeric and `.`
            return not ctx:text_after_cursor(1):match("[%w%.]")
          end,
        },
      },
      ["["] = {
        {
          "[",
          "]",
          space = function(ctx)
            return not ctx.ts:is_language("markdown")
              -- ignore markdown todo items (bullets and numbered)
              or (
                not ctx:text_before_cursor():match("^%s*[%*%-+]%s+%[%s*$")
                and not ctx:text_before_cursor():match("^%s*%d+%.%s+%[%s*$")
              )
          end,
          when = function(ctx)
            -- ignore alphanumeric and `.`
            return not ctx:text_after_cursor(1):match("[%w%.]")
          end,
        },
      },
      ["{"] = {
        {
          "{",
          "}",
          when = function(ctx)
            -- ignore alphanumeric and `.`
            return not ctx:text_after_cursor(1):match("[%w%.]")
          end,
        },
      },
      ["'"] = {
        {
          "'",
          enter = false,
          space = false,
          when = function(ctx)
            -- The `plaintex` filetype has no treesitter parser, so we can't disable
            -- this pair in math environments. Thus, disable this pair completely.
            -- TODO: disable inside "" strings?
            return ctx.ft ~= "plaintext"
              and ctx.ft ~= "scheme"
              and ctx.ft ~= "fennel"
              and (not ctx.char_under_cursor:match("%w") or ctx:is_after_cursor("'"))
              and ctx.ts:blacklist("singlequote").matches
              -- ignore alphanumeric and `.`
              and not ctx:text_after_cursor(1):match("[%w%.]")
          end,
        },
      },
      ['"'] = {
        {
          '"',
          enter = false,
          space = false,
          when = function(ctx)
            -- ignore alphanumeric and `.`
            return not ctx:text_after_cursor(1):match("[%w%.]")
          end,
        },
      },
      ["`"] = {
        {
          "`",
          enter = false,
          space = false,
          when = function(ctx)
            -- ignore alphanumeric and `.`
            return not ctx:text_after_cursor(1):match("[%w%.]")
          end,
        },
      },
    }

    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    local opts = {
      mappings = {
        -- you can call require("blink.pairs.mappings").enable()
        -- and require("blink.pairs.mappings").disable()
        -- to enable/disable mappings at runtime
        enabled = true,
        cmdline = true,
        disabled_filetypes = ui_filetypes.all,
        pairs = vim.tbl_deep_extend("force", default_pairs, custom_pairs),
      },
      highlights = {
        enabled = true,
        cmdline = true,
        groups = ui_highlights.rainbow,
      },
    }

    return opts
  end,
}
