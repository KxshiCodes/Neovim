local function create_autocmd(opts)
  vim.api.nvim_create_autocmd({ "LspAttach" }, {
    group = vim.api.nvim_create_augroup("lsp_attach_" .. opts.name, { clear = true }),
    desc = "LSP: " .. opts.desc,
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      opts.callback(client, buffer)
    end,
  })
end

local function is_c(client)
  return client.name == "clangd"
end

local function is_cargo_toml(client)
  return client.name == "taplo" and vim.fn.expand("%:t") == "Cargo.toml"
end

local function is_python(client)
  return vim.list_contains({
    "ruff",
    "ty",
    "pyright",
    "pylsp",
  }, client)
end

local function is_rust(client)
  return client.name == "rust-analyzer"
end

local function setup_keymaps()
  create_autocmd({
    name = "keymaps",
    desc = "keymaps",
    callback = function(client, buffer)
      if client == nil then
        return
      end

      require("which-key").add({
        {
          mode = { "n" },
          buffer = buffer,
          { "grr", Snacks.picker.lsp_references, desc = "Go to reference" },
          { "grd", Snacks.picker.lsp_definitions, desc = "Go to definition" },
          { "grt", Snacks.picker.lsp_type_definitions, desc = "Go to type definition" },
          { "gri", Snacks.picker.lsp_implementations, desc = "Go to implementation" },
          { "grD", Snacks.picker.lsp_declarations, desc = "Go to declaration" },

          { "grn", vim.lsp.buf.rename, desc = "Rename" },
          { "grA", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "x" } },
          { "grk", vim.lsp.buf.signature_help, desc = "Show signature help" },

          { "<leader>il", "<cmd>LspInfo<cr>", desc = "Show LSP info" },
          { "<leader>iR", "<cmd>LspRestart " .. client.name .. "<cr>", desc = "Restart attached LSP server" },
          {
            "<leader>ir",
            function()
              Snacks.picker.lsp_config({
                attached = true,
                confirm = function()
                  vim.cmd("LspRestart " .. client.name)
                end,
              })
            end,
            desc = "Restart LSP server",
          },

          { "gO", Snacks.picker.lsp_symbols, desc = "Show document symbols" },
          { "grs", Snacks.picker.lsp_symbols, desc = "Show buffer symbols" },
          { "grS", Snacks.picker.lsp_workspace_symbols, desc = "Show workspace symbols" },
        },
      })
    end,
  })
end

local function setup_hover_keymaps()
  create_autocmd({
    name = "hover_keymaps",
    desc = "hover keymaps",
    callback = function(client, buffer)
      if client == nil then
        return
      end

      local default_opts = {
        handler = function()
          require("hover").open()
        end,
        desc = "Hover",
        mode = { "n" },
      }

      local opts = {}

      if is_rust(client) then
        opts = {
          handler = function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end,
          desc = "Hover actions",
        }
      elseif is_cargo_toml(client) then
        opts = {
          handler = function()
            if require("crates").popup_available() then
              require("crates").show_popup()
            else
              require("hover").open()
            end
          end,
          desc = "Hover crate",
        }
      end

      local merged_opts = vim.tbl_deep_extend("force", default_opts, opts)

      require("which-key").add({
        {
          mode = { "n" },
          buffer = buffer,
          {
            "gK",
            function()
              vim.lsp.buf.hover()
            end,
            desc = "Hover",
          },
        },
        {
          mode = merged_opts.mode,
          buffer = buffer,
          {
            "K",
            function()
              if not require("ufo").peekFoldedLinesUnderCursor() then
                merged_opts.handler()
              end
            end,
            desc = merged_opts.desc,
          },
        },
      })
    end,
  })
end

local function setup_c_keymaps()
  create_autocmd({
    name = "c_keymaps",
    desc = "C keymaps",
    callback = function(client, buffer)
      if client == nil then
        return
      end

      if not is_c(client) then
        return
      end

      require("which-key").add({
        {
          mode = { "n" },
          buffer = buffer,
          { "<localleader>", group = "c" },
        },
      })
    end,
  })
end

local function setup_cargo_toml_keymaps()
  create_autocmd({
    name = "cargo_toml_keymaps",
    desc = "Cargo.toml keymaps",
    callback = function(client, buffer)
      if client == nil then
        return
      end

      if not is_cargo_toml(client) then
        return
      end

      require("which-key").add({
        {
          mode = { "n" },
          buffer = buffer,
          { "<localleader>", group = "crates" },
          { "<localleader>i", require("crates").toggle, desc = "Toggle crates info" },
          { "<localleader>D", require("crates").reload, desc = "Reload data" },
          { "<localleader>u", require("crates").upgrade_crate, desc = "Upgrade crate" },
          { "<localleader>U", require("crates").upgrade_all_crates, desc = "Upgrade all crates" },
          { "<localleader>e", require("crates").expand_plain_crate_to_inline_table, desc = "Expand to inline table" },
          { "<localleader>E", require("crates").extract_crate_into_table, desc = "Extract into table" },
          { "<localleader>s", group = "show" },
          { "<localleader>sc", require("crates").show_crate_popup, desc = "Show crate popup" },
          { "<localleader>sv", require("crates").show_versions_popup, desc = "Show versions popup" },
          { "<localleader>sf", require("crates").show_features_popup, desc = "Show features popup" },
          { "<localleader>sd", require("crates").show_dependencies_popup, desc = "Show dependencies popup" },
          { "<localleader>o", group = "open" },
          { "<localleader>oh", require("crates").open_homepage, desc = "Open homepage" },
          { "<localleader>or", require("crates").open_repository, desc = "Open repository" },
          { "<localleader>od", require("crates").open_documentation, desc = "Open documentation" },
          { "<localleader>oc", require("crates").open_crates_io, desc = "Open crates.io" },
        },
        {
          mode = { "x" },
          buffer = buffer,
          { "<localleader>", group = "crates" },
          { "<localleader>u", require("crates").upgrade_crates, desc = "Upgrade crates" },
        },
      })
    end,
  })
end

local function setup_python_keymaps()
  create_autocmd({
    name = "python_keymaps",
    desc = "Python keymaps",
    callback = function(client, buffer)
      if client == nil then
        return
      end

      if not is_python(client) then
        return
      end

      require("which-key").add({
        {
          mode = { "n" },
          buffer = buffer,
          { "<localleader>", group = "python" },
        },
      })
    end,
  })
end

local function setup_rust_keymaps()
  create_autocmd({
    name = "rust_keymaps",
    desc = "Rust keymaps",
    callback = function(client, buffer)
      if client == nil then
        return
      end

      if not is_rust(client) then
        return
      end

      local function rust_map(key, action, desc)
        return {
          key,
          function()
            vim.cmd.RustLsp(action)
          end,
          desc = desc,
        }
      end

      require("which-key").add({
        {
          mode = "n",
          buffer = buffer,
          {
            "]b",
            "<cmd>BaconLoad<cr><cmd>w<cr><cmd>BaconNext<cr><cmd>lua vim.diagnostic.open_float()<cr>",
            desc = "Next bacon file",
          },
          {
            "[b",
            "<cmd>BaconLoad<cr><cmd>w<cr><cmd>BaconPrevious<cr><cmd>lua vim.diagnostic.open_float()<cr>",
            desc = "Previous bacon file",
          },

          { "<localleader>", group = "rust" },
          {
            "<localleader>h",
            function()
              require("lspconfig.configs.rust_analyzer").commands.CargoReload[1]()
            end,
            desc = require("lspconfig.configs.rust_analyzer").commands.CargoReload.description,
          },
          rust_map("<localleader>j", "joinLines", "Join lines"),
          rust_map("<localleader>a", "codeAction", "Code action"),
          rust_map("<localleader>d", "renderDiagnostic", "Show diagnostic"),
          rust_map("<localleader>e", "explainError", "Explain error"),
          rust_map("<localleader>p", "parentModule", "Open parent module"),
          rust_map("<localleader>c", "openCargo", "Open Cargo.toml"),
          rust_map("<localleader>o", "openDocs", "Open documentation"),
          {
            "<localleader><Up>",
            function()
              vim.cmd.RustLsp("moveItem", "up")
            end,
            desc = "Move item up",
          },
          {
            "<localleader><Down>",
            function()
              vim.cmd.RustLsp("moveItem", "down")
            end,
            desc = "Move item down",
          },
          {
            "<localleader>b",
            function()
              vim.cmd("BaconLoad")

              Snacks.picker.qflist()
            end,
            desc = "Show bacon locations",
          },
          { "<localleader>t", group = "find" },
        },
      })
    end,
  })
end

local function setup_codelens()
  create_autocmd({
    name = "codelens",
    desc = "codelens",
    callback = function(client, buffer)
      if client == nil then
        return
      end

      if not client.server_capabilities.codeLensProvider then
        return
      end

      vim.lsp.codelens.enable(false, { client_id = client })

      require("which-key").add({
        {
          mode = "n",
          buffer = buffer,
          {
            "<leader>ul",
            function()
              vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled(), {
                client_id = client,
              })
            end,
            desc = "Toggle codelens",
          },
          {
            "grx",
            function()
              vim.lsp.codelens.run({
                client_id = client,
              })
            end,
            desc = "Run codelens",
          },
        },
      })
    end,
  })
end

local function setup_ruff_hover()
  create_autocmd({
    name = "disable_ruff_hover",
    desc = "Disable hover capability from Ruff",
    callback = function(client, _buffer)
      if client == nil then
        return
      end

      if client.name == "ruff" then
        client.server_capabilities.hoverProvider = false
      end
    end,
  })
end

return {
  "neovim/nvim-lspconfig",
  cmd = {
    "LspInfo",
  },
  init = function()
    setup_keymaps()
    setup_hover_keymaps()
    setup_c_keymaps()
    setup_cargo_toml_keymaps()
    setup_python_keymaps()
    setup_rust_keymaps()
    setup_codelens()
    setup_ruff_hover()
  end,
}
