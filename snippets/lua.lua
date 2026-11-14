--# selene: allow(unused_variable)

local ls = require("luasnip")
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

ls.add_snippets("lua", {
  ls.s(
    "require_module",
    fmt('local {} = require("{}")', {
      ls.i(1, "module"),
      rep(1),
    })
  ),
  ls.s(
    "require_submodule",
    fmt('local {} = require("{}")', {
      ls.f(function(import_name)
        local parts = vim.split(import_name[1][1], ".", { plain = true, trimempty = true })
        return parts[#parts] or ""
      end, { 1 }),
      ls.i(1),
    })
  ),
})
