return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    version = false,
  },
  keys = {
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
      desc = "Open all folds",
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
      desc = "Close all folds",
    },
  },
  init = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.opt.foldcolumn = "1"
  end,
  opts = {
    preview = {
      win_config = {
        border = { "", "─", "", "", "", "─", "", "" },
        winblend = 0,
      },
      mappings = {
        scrollU = "<PageUp>",
        scrollD = "<PageDown>",
        jumpTop = "<Home>",
        jumpBot = "<End>",
      },
    },
    -- selene: allow(unused_variable)
    provider_selector = function(buffer, filetype, buftype)
      return { "lsp", "indent" }
    end,
    -- source: https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file#customize-fold-text
    fold_virt_text_handler = function(virtual_text, line_number, end_line_number, width, truncate)
      local new_virtual_text = {}
      local suffix = (" 󰁂 %d "):format(end_line_number - line_number)
      local suffix_width = vim.fn.strdisplaywidth(suffix)
      local target_width = width - suffix_width
      local current_width = 0

      for _, chunk in ipairs(virtual_text) do
        local chunk_text = chunk[1]
        local chunk_width = vim.fn.strdisplaywidth(chunk_text)

        if target_width > current_width + chunk_width then
          table.insert(new_virtual_text, chunk)
        else
          chunk_text = truncate(chunk_text, target_width - current_width)
          local highlight_group = chunk[2]
          table.insert(new_virtual_text, { chunk_text, highlight_group })
          chunk_width = vim.fn.strdisplaywidth(chunk_text)

          -- str width returned from truncate() may less than 2nd argument, need padding
          if current_width + chunk_width < target_width then
            suffix = suffix .. (" "):rep(target_width - current_width - chunk_width)
          end

          break
        end

        current_width = current_width + chunk_width
      end

      table.insert(new_virtual_text, { suffix, "MoreMsg" })

      return new_virtual_text
    end,
  },
}
