return {
  enabled = true,
  completion = {
    list = { selection = { preselect = true, auto_insert = true } },
    menu = { auto_show = true },
    ghost_text = { enabled = true },
  },
  sources = function()
    local type = vim.fn.getcmdtype()

    if type == "/" or type == "?" then
      return { "buffer" }
    end

    if type == ":" or type == "@" then
      return { "cmdline", "path" }
    end

    return {}
  end,
  keymap = {
    preset = "none",

    ["<C-c>"] = { "cancel" },

    ["<C-y>"] = {
      function(cmp)
        cmp.select_and_accept({
          callback = function()
            cmp.show()
          end,
        })
      end,
    },

    ["<Tab>"] = {
      function(cmp)
        if cmp.is_ghost_text_visible() then
          cmp.select_and_accept({
            callback = function()
              cmp.show()
            end,
          })
        else
          cmp.select_next()
        end
      end,
    },
    ["<S-Tab>"] = { "select_prev" },

    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
  },
}
