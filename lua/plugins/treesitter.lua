if vim.fn.executable("tree-sitter") == 0 then
  local url = "https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md"

  vim.notify("Install `tree-sitter-cli`:\n" .. url, vim.log.levels.ERROR, {
    title = "nvim-treesitter",
    timeout = false,
  })
end

local languages = require("config.languages")

return {
  "neovim-treesitter/nvim-treesitter",
  branch = "main",
  version = false,
  dependencies = {
    "neovim-treesitter/treesitter-parser-registry",
  },
  build = function()
    require("nvim-treesitter").update()
  end,
  lazy = false,
  priority = 500,
  cmd = {
    "TSInstall",
    "TSUpdate",
    "TSUninstall",
    "TSRegistryUpdate",
    "TSStatus",
    "TSLog",
  },
  config = function()
    require("nvim-treesitter").install(languages.treesitter_parsers())

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter.setup", {}),
      callback = function(args)
        local language = vim.treesitter.language.get_lang(args.match)
        if not language then
          return
        end

        local available = require("nvim-treesitter").get_available()
        local installed = require("nvim-treesitter").get_installed()
        if vim.tbl_contains(available, language) and not vim.tbl_contains(installed, language) then
          require("nvim-treesitter").install(language):wait(10000)
        end

        local loaded, cannot_load = vim.treesitter.language.add(language)
        if cannot_load then
          return
        end
        if not loaded then
          return
        end

        vim.treesitter.start(args.buf, language)
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    vim.api.nvim_create_autocmd({ "VimEnter" }, {
      group = vim.api.nvim_create_augroup("treesitter.update", {}),
      callback = function()
        vim.schedule(function()
          require("nvim-treesitter").update()
        end)
      end,
    })
  end,
}
