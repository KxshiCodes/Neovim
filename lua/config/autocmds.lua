local function custom_augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = custom_augroup("close_with_q"),
  pattern = {
    -- LazyVim
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "checkhealth",
    "HardtimeReport",
    -- https://github.com/Allaman/nvim/blob/main/lua/core/autocmd.lua
    "git",
    "fugitive",
    "dap-float",
    "gitsigns-blame",
  },
  callback = function(args)
    vim.bo[args.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = args.buf,
      silent = true,
      noremap = true,
    })
  end,
})

-- Forget Plugins! Neovim IDE features with Autocmds
-- https://youtu.be/v36vLiFVOXY

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
  group = custom_augroup("restore_cursor_position"),
  callback = function(args)
    local buffer = args.buf

    local mark = vim.api.nvim_buf_get_mark(buffer, '"')
    local line_count = vim.api.nvim_buf_line_count(buffer)

    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd("normal! zz")
      end)
    end
  end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
  group = custom_augroup("open_help_vertical_split"),
  pattern = "help",
  command = "wincmd L",
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = custom_augroup("resize_splits_on_window_resize"),
  command = "wincmd =",
})

-- create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = custom_augroup("create_directory_when_saving_files"),
  callback = function(args)
    if vim.bo[args.buf].filetype == "oil" then
      return
    end

    local directory = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(directory) == 0 then
      vim.fn.mkdir(directory, "p")
    end
  end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
  group = custom_augroup("syntax_highlighting_dotenv"),
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.bo.filetype = "dosini"
  end,
})

-- show cursorline in active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = custom_augroup("cursorline_show"),
  callback = function(args)
    if vim.bo[args.buf].filetype ~= "snacks_dashboard" then
      vim.opt_local.cursorline = true
    end
  end,
})

-- hide cursorline in inactive window
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = custom_augroup("cursorline_hide"),
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
