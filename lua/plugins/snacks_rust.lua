-- TODO(snacks): create builder function for rust sources

if not require("config.languages").is_enabled("rust") then
  return {}
end

return {
  "folke/snacks.nvim",
  optional = true,
  keys = {
    {
      "<localleader>fp",
      function()
        Snacks.picker.pick("rust_panic")
      end,
      desc = "Find panic",
      ft = {
        "rust",
      },
    },
    {
      "<localleader>ft",
      function()
        Snacks.picker.pick("rust_todo")
      end,
      desc = "Find todo",
      ft = {
        "rust",
      },
    },
    {
      "<localleader>fu",
      function()
        Snacks.picker.pick("rust_unimplemented")
      end,
      desc = "Find unimplemented",
      ft = {
        "rust",
      },
    },
    {
      "<localleader>fU",
      function()
        Snacks.picker.pick("rust_unreachable")
      end,
      desc = "Find unreachable",
      ft = {
        "rust",
      },
    },
  },
  opts = function(_, opts)
    local panic = {
      title = "panic!()",
      format = "file",
      finder = "grep",
      supports_live = true,
      search = "panic!",
    }

    local todo = {
      title = "todo!()",
      format = "file",
      finder = "grep",
      supports_live = true,
      search = "todo!",
    }

    local unimplemented = {
      title = "unimplemented!()",
      format = "file",
      finder = "grep",
      supports_live = true,
      search = "unimplemented!",
    }

    local unreachable = {
      title = "unreachable!()",
      format = "file",
      finder = "grep",
      supports_live = true,
      search = "unreachable!",
    }

    local new_opts = {
      picker = {
        sources = {
          rust_panic = panic,
          rust_todo = todo,
          rust_unimplemented = unimplemented,
          rust_unreachable = unreachable,
        },
      },
    }

    return vim.tbl_deep_extend("force", opts or {}, new_opts)
  end,
}
