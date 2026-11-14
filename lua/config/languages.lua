local M = {}

local language_config = {
  c = true,
  editorconfig = true,
  git = true,
  html = false,
  json = false,
  lua = true,
  make = true,
  markdown = false,
  nix = false,
  python = true,
  rust = false,
  salt = false,
  shell = true,
  sql = false,
  toml = false,
  vim = true,
  xml = false,
  yaml = false,
}

--- Check if the language is enabled or not.
---@param language string
---@return boolean?
function M.is_enabled(language)
  return language_config[language]
end

--- Select the values for all enabled languages.
---@param registry table<string, table<any>>
---@return table<any>
function M.select_enabled(registry)
  return vim
    .iter(registry)
    :filter(function(item)
      return M.is_enabled(item) == true
    end)
    :fold({}, function(acc, _language, value)
      local success, extended = pcall(vim.tbl_deep_extend, "error", acc, value)

      if success then
        return extended
      end

      vim.list_extend(acc, value)

      return acc
    end)
end

function M.treesitter_parsers()
  if vim.fn.executable("tree-sitter") ~= 1 then
    return {}
  end

  local parsers = {
    c = { "c", "cpp" },
    editorconfig = { "editorconfig" },
    git = {
      "diff",
      "git_config",
      "git_rebase",
      "gitcommit",
      "gitattributes",
      "gitignore",
    },
    html = { "html" },
    json = { "json" },
    lua = { "lua", "luadoc" },
    make = { "make" },
    markdown = { "markdown", "markdown_inline" },
    nix = { "nix" },
    python = { "python" },
    rust = { "rust" },
    salt = {},
    shell = { "bash", "fish", "zsh" },
    sql = { "sql" },
    toml = { "toml" },
    vim = { "vim", "vimdoc", "printf", "query", "regex" },
    xml = { "xml" },
    yaml = { "yaml" },
  }

  return M.select_enabled(parsers)
end

function M.mason_tools()
  local tools = {
    c = { "c_formatter_42", "clangd", "norminette" },
    editorconfig = { "editorconfig-checker" },
    git = { "commitlint", "gitlint" },
    html = {},
    json = { "jsonlint", "prettier" },
    lua = { "lua_ls", "selene", "stylua" },
    make = { "checkmake", "mbake" },
    markdown = { "prettier" },
    nix = { "alejandra", "statix", "nil_ls" },
    python = { "ruff", "ty" },
    rust = {},
    salt = { "djlint", "salt-lint", "yamlfmt" },
    shell = { "bashls", "shellcheck", "shfmt" },
    sql = {},
    toml = { "taplo" },
    vim = {},
    xml = {},
    yaml = { "yamlfmt", "yamllint", "yamlls" },
  }

  return M.select_enabled(tools)
end

function M.conform_formatters()
  local formatters = {
    c = {
      c = { "c_formatter_42", lsp_format = "never" },
      cpp = { "c_formatter_42", lsp_format = "never" },
    },
    editorconfig = {},
    git = {},
    html = {},
    json = {
      json = { "prettier" },
    },
    lua = {
      lua = { "stylua" },
    },
    make = {
      -- TODO(conform): manually create mbake formatter
      -- make = { "mbake" },
    },
    markdown = {
      markdown = { "prettier" },
    },
    nix = {
      nix = { "alejandra" },
    },
    python = {
      python = {
        -- To fix auto-fixable lint errors.
        "ruff_fix",
        -- To run the Ruff formatter.
        "ruff_format",
        -- To organize the imports.
        "ruff_organize_imports",
      },
    },
    rust = {},
    salt = {
      salt = { "djlint", "yamlfmt" },
    },
    shell = {
      bash = { "shfmt" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
    },
    sql = {
      sql = { "sql-formatter" },
    },
    toml = {
      toml = { "taplo" },
    },
    vim = {},
    xml = {},
    yaml = {
      yaml = { "yamlfmt" },
    },
  }

  return M.select_enabled(formatters)
end

function M.lint_linters()
  local linters = {
    c = {
      c = { "norminette" },
      cpp = { "norminette" },
    },
    editorconfig = {
      editorconfig = { "editorconfig-checker" },
    },
    git = {
      commit = { "commitlint" },
      git = { "gitlint" },
    },
    html = {},
    json = {
      json = { "jsonlint" },
    },
    lua = {
      lua = { "selene" },
    },
    make = {
      make = { "checkmake" },
    },
    markdown = {},
    nix = {
      nix = { "statix" },
    },
    python = {},
    rust = {},
    salt = {
      salt = { "djlint", "saltlint" },
    },
    shell = {
      bash = { "shellcheck" },
    },
    sql = {},
    toml = {},
    vim = {},
    xml = {},
    yaml = {
      yaml = { "yamllint" },
    },
  }

  return M.select_enabled(linters)
end

return M
