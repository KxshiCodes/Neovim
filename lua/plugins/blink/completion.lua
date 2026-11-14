local ui_style = require("ui.style")

local nvim_web_devicons = require("nvim-web-devicons")
local lspkind = require("lspkind")
local colorful_menu = require("colorful-menu")

return {
  list = { selection = { preselect = true, auto_insert = true } },
  menu = {
    enabled = true,
    min_width = 20,
    max_height = 10,
    border = ui_style.border.none,
    scrollbar = true,
    auto_show = true,
    cmdline_position = function()
      local position = vim.g.ui_cmdline_pos
      if position ~= nil then
        local row = position[1]
        local col = position[2]
        if row ~= nil and col ~= nil then
          return { row - 1, col }
        else
          vim.notify(
            "malformed `vim.g.ui_cmdline_pos`:\ncheck [repository](https://github.com/folke/noice.nvim/)",
            vim.log.levels.ERROR,
            {
              id = "malformed vim.g.ui_cmdline_pos",
              title = "Noice",
              timeout = false,
            }
          )
          return { vim.o.lines / 2, vim.o.columns / 2.5 }
        end
      end

      local height = math.max(1, vim.o.cmdheight)
      return { vim.o.lines - height, 0 }
    end,
    draw = {
      columns = { { "kind_icon" }, { "label", gap = 1 }, { "kind" }, { "source_name" } },
      components = {
        kind_icon = {
          ellipsis = false,
          text = function(ctx)
            if vim.tbl_contains({ "Path" }, ctx.source_name) then
              local icon, _highlight = nvim_web_devicons.get_icon(ctx.label)
              if icon then
                return icon .. ctx.icon_gap
              end
            end

            local icon = lspkind.symbol_map[ctx.kind]
            if icon then
              return icon .. ctx.icon_gap
            end

            return ctx.kind_icon .. ctx.icon_gap
          end,
          highlight = function(ctx)
            if vim.tbl_contains({ "Path" }, ctx.source_name) then
              local icon, highlight = nvim_web_devicons.get_icon(ctx.label)
              if icon then
                return highlight
              end
            end

            return ctx.kind_hl
          end,
        },
        kind = {
          ellipsis = false,
          width = { fill = true, max = 10 },
          text = function(ctx)
            return ctx.kind
          end,
          highlight = function(ctx)
            if vim.tbl_contains({ "Path" }, ctx.source_name) then
              local icon, highlight = nvim_web_devicons.get_icon(ctx.label)
              if icon then
                return highlight
              end
            end

            return ctx.kind_hl
          end,
        },
        label = {
          width = { fill = true, max = 60 },
          text = function(ctx)
            return colorful_menu.blink_components_text(ctx)
          end,
          highlight = function(ctx)
            return colorful_menu.blink_components_highlight(ctx)
          end,
        },
        label_description = {
          width = { max = 20 },
          text = function(ctx)
            return ctx.label_description
          end,
          highlight = "BlinkCmpLabelDescription",
        },
        source_name = {
          width = { fill = true, max = 20 },
          text = function(ctx)
            return ctx.source_name
          end,
          highlight = "BlinkCmpSource",
        },
      },
    },
  },
  documentation = {
    auto_show = true,
    auto_show_delay_ms = 0,
    update_delay_ms = 50,
    treesitter_highlighting = true,
    window = {
      min_width = 20,
      max_width = ui_style.floating_window.max_width,
      max_height = ui_style.floating_window.max_height,
      border = ui_style.border.padded,
      scrollbar = true,
    },
  },
  ghost_text = { enabled = true },
}
