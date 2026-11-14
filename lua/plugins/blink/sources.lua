local function treesitter_node_is_comment()
  local success, node = pcall(vim.treesitter.get_node)
  local comment_types = { "comment", "line_comment", "block_comment", "comment_content" }

  return success and node and vim.tbl_contains(comment_types, node:type())
end

return {
  default = function(_ctx)
    if treesitter_node_is_comment() then
      return { "path", "buffer" }
    else
      return {
        -- builtin
        "lsp",
        "snippets",
        "path",
        "buffer",

        -- community
        "dadbod",
        "lazydev",
        "git",
        "nerdfont",
        "choice",
        "ripgrep",
      }
    end
  end,
  per_filetype = {
    oil = { "path", "buffer" },
    sql = { "dadbod", "path", "buffer" },
  },

  -- Please see https://github.com/Saghen/blink.compat for using `nvim-cmp` sources
  providers = {
    snippets = {
      score_offset = 60,
      max_items = 5,
      transform_items = function(_, items)
        if treesitter_node_is_comment() then
          return {}
        else
          return items
        end
      end,
      opts = {
        use_show_condition = true,
        show_autosnippets = false,
      },
    },
    lsp = {
      score_offset = 60,
      transform_items = function(_, items)
        local types = require("blink.cmp.types")
        local blacklist = { types.CompletionItemKind.Snippet, types.CompletionItemKind.Text }

        return vim.tbl_filter(function(item)
          return not vim.tbl_contains(blacklist, item.kind)
        end, items)
      end,
    },
    path = {
      score_offset = 50,
      opts = {
        trailing_slash = true,
        label_trailing_slash = true,
        show_hidden_files_by_default = true,
      },
    },
    buffer = {
      score_offset = 10,
    },
    dadbod = {
      name = "Dadbod",
      module = "vim_dadbod_completion.blink",
      score_offset = 100,
      enabled = function()
        return vim.tbl_contains({ "sql" }, vim.bo.filetype)
      end,
    },
    lazydev = {
      name = "LazyDev",
      module = "lazydev.integrations.blink",
      score_offset = 100,
      enabled = function()
        return vim.bo.filetype == "lua"
      end,
    },
    git = {
      name = "Git",
      module = "blink-cmp-git",
      score_offset = 10,
      min_keyword_length = 1,
      enabled = function()
        return vim.tbl_contains({ "gitcommit", "markdown" }, vim.bo.filetype)
      end,
      opts = {
        commit = {
          triggers = { ":" },
        },
      },
    },
    nerdfont = {
      name = "Nerd Fonts",
      module = "blink-nerdfont",
      score_offset = 50,
      min_keyword_length = 3,
      enabled = function()
        return vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype)
      end,
      opts = {
        insert = true,
        trigger = ":",
      },
    },
    choice = {
      name = "LuaSnip Choice Nodes",
      module = "blink-cmp-luasnip-choice",
      score_offset = 50,
      opts = {},
    },
    ripgrep = {
      name = "Ripgrep",
      module = "blink-ripgrep",
      score_offset = 10,
      ---@module "blink-ripgrep"
      ---@type blink-ripgrep.Options
      opts = {
        prefix_min_len = 3,
        backend = {
          ---@type "ripgrep" | "gitgrep" | "gitgrep-or-ripgrep"
          use = "gitgrep-or-ripgrep",
        },
      },
    },
  },
}
