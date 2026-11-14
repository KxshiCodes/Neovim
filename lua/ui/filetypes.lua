local M = {}

M.app = {
  "lazy",
  "mason",
  "oil",
  "snacks_dashboard",
}

M.popup = {
  "cmp",
  "cmp_docs",
  "cmp_menu",
  "noice",
  "notify",
}

M.prompt = {
  "DressingSelect",
  "flash_prompt",
  "prompt",
  "snacks_picker_input",
  "snacks_input",
}

M.blink = {
  "DressingSelect",
  "flash_prompt",
  "prompt",
  "snacks_picker_input",
}

M.lualine = {
  "lazy",
  "mason",
  "oil",
  "prompt",
  "snacks_dashboard",
}

M.hardtime = {
  "DressingSelect",
  "flash_prompt",
  "lazy",
  "mason",
  "oil",
  "prompt",
  "snacks_dashboard",
  "snacks_picker_input",
  "snacks_input",
}

M.flash = {
  "cmp",
  "cmp_docs",
  "cmp_menu",
  "DressingSelect",
  "flash_prompt",
  "lazy",
  "mason",
  "noice",
  "notify",
  "prompt",
  "snacks_dashboard",
  "snacks_picker_input",
  "snacks_input",
  -- exclude non-focusable windows
  function(win)
    return not vim.api.nvim_win_get_config(win).focusable
  end,
}

M.all = {
  "cmp",
  "cmp_docs",
  "cmp_menu",
  "DressingSelect",
  "flash_prompt",
  "git",
  "gitcommit",
  "gitrebase",
  "lazy",
  "mason",
  "NeogitStatus",
  "noice",
  "notify",
  "oil",
  "prompt",
  "snacks_dashboard",
  "snacks_picker_input",
  "snacks_input",
  "sql",
  "vim",
}

return M
