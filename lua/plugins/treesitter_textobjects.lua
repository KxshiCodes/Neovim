---@param opts table
---@param name string
---@param func function(integer, string, table) -> table
local function treesitter_create_autocmd(opts, name, func)
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter_" .. name, { clear = true }),
    desc = "Treesitter: " .. name .. " keymaps",
    callback = function(args)
      if not vim.tbl_get(opts, name, "enable") then
        return
      end

      local which_key = require("which-key")

      local key_methods = vim.tbl_get(opts, name, "keymaps") or {}
      for method, keymaps in pairs(key_methods) do
        for key, query in pairs(keymaps) do
          which_key.add(func(args.buf, method, key, query))
        end
      end
    end,
  })
end

---@param str string
---@param ending string
local function ends_with(str, ending)
  return ending == "" or str:sub(-#ending) == ending
end

local function treesitter_select(buffer, method, key, query)
  ---@type string|string[]
  local query_string = type(query) == "table" and query.query or query
  ---@type string
  local query_group = type(query) == "table" and query.group or "textobjects"
  ---@type string[]
  local queries = type(query_string) == "string" and { query_string } or query

  local parts = {}
  for _, q in ipairs(queries) do
    local part = q:gsub("@", ""):gsub("%..*", "")
    table.insert(parts, part)
  end

  local desc = table.concat(parts, " or ")

  if key:sub(1, 1) == "i" then
    desc = "inner " .. desc
  end

  return {
    mode = { "x", "o" },
    buffer = buffer,
    {
      key,
      function()
        require("nvim-treesitter-textobjects.select")[method](query_string, query_group)
      end,
      desc = desc,
    },
  }
end

local function treesitter_move(buffer, method, key, query)
  ---@type string|string[]
  local query_string = type(query) == "table" and query.query or query
  ---@type string
  local query_group = type(query) == "table" and query.group or "textobjects"
  ---@type string[]
  local queries = type(query_string) == "string" and { query_string } or query

  local parts = {}
  for _, q in ipairs(queries) do
    local part = q:gsub("@", ""):gsub("%..*", "")
    table.insert(parts, part)
  end

  local desc = table.concat(parts, " or ")

  if ends_with(method, "_start") then
    desc = desc .. " start"
  elseif ends_with(method, "_end") then
    desc = desc .. " end"
  end

  if key:sub(1, 1) == "[" then
    desc = "previous " .. desc
  elseif key:sub(1, 1) == "]" then
    desc = "next " .. desc
  end

  desc = desc:sub(1, 1):upper() .. desc:sub(2)

  return {
    mode = { "n", "x", "o" },
    buffer = buffer,
    {
      key,
      function()
        require("nvim-treesitter-textobjects.move")[method](query_string, query_group)
      end,
      desc = desc,
    },
  }
end

local function treesitter_swap(buffer, method, key, query)
  ---@type string|string[]
  local query_string = type(query) == "table" and query.query or query
  ---@type string[]
  local queries = type(query_string) == "string" and { query_string } or query

  local parts = {}
  for _, q in ipairs(queries) do
    local part = q:gsub("@", ""):gsub("%..*", "")
    table.insert(parts, part)
  end

  local desc = table.concat(parts, " or ")

  if ends_with(method, "_next") then
    desc = "next " .. desc
  elseif ends_with(method, "_previous") then
    desc = "previous " .. desc
  end

  desc = "swap " .. desc

  desc = desc:sub(1, 1):upper() .. desc:sub(2)

  return {
    mode = { "n" },
    buffer = buffer,
    {
      key,
      function()
        require("nvim-treesitter-textobjects.swap")[method](query_string)
      end,
      desc = desc,
    },
  }
end

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  version = false,
  dependencies = {
    "neovim-treesitter/nvim-treesitter",
  },
  event = {
    "BufRead",
  },
  opts = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        select_textobject = {
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ao"] = "@loop.outer",
          ["io"] = "@loop.inner",
        },
      },
      selection_modes = {
        ["@parameter.outer"] = "v",
        ["@function.outer"] = "v",
        ["@class.outer"] = "V",
      },
      include_surrounding_whitespace = false,
    },
    move = {
      enable = true,
      set_jumps = true,
      keymaps = {
        goto_next = {},
        goto_next_start = {
          ["]a"] = "@parameter.outer",
          ["]c"] = "@class.outer",
          ["]f"] = "@function.outer",
          ["]i"] = "@conditional.outer",
          ["]o"] = "@loop.outer",
          ["]r"] = "@return.outer",
          ["]z"] = { query = "@fold", group = "folds" },
        },
        goto_next_end = {
          ["]A"] = "@parameter.outer",
          ["]C"] = "@class.outer",
          ["]F"] = "@function.outer",
          ["]I"] = "@conditional.outer",
          ["]O"] = "@loop.outer",
        },
        goto_previous = {},
        goto_previous_start = {
          ["[a"] = "@parameter.outer",
          ["[c"] = "@class.outer",
          ["[f"] = "@function.outer",
          ["[i"] = "@conditional.outer",
          ["[o"] = "@loop.outer",
          ["[r"] = "@return.outer",
          ["[z"] = { query = "@fold", group = "folds" },
        },
        goto_previous_end = {
          ["[A"] = "@parameter.outer",
          ["[C"] = "@class.outer",
          ["[F"] = "@function.outer",
          ["[I"] = "@conditional.outer",
          ["[O"] = "@loop.outer",
        },
      },
    },
    swap = {
      enable = true,
      keymaps = {
        swap_next = {
          ["]x"] = "@parameter.inner",
        },
        swap_previous = {
          ["[x"] = "@parameter.inner",
        },
      },
    },
  },
  config = function(_, opts)
    local textobjects = require("nvim-treesitter-textobjects")

    textobjects.setup(opts)

    treesitter_create_autocmd(opts, "select", treesitter_select)
    treesitter_create_autocmd(opts, "move", treesitter_move)
    treesitter_create_autocmd(opts, "swap", treesitter_swap)
  end,
}
