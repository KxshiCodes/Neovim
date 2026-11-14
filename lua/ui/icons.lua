local M = {}

M.documents = {
  folder = {
    closed = " ",
    closed_outline = " ",
    open = " ",
    open_outline = " ",
    plus = " ",
    minus = " ",
    tree = " ",
    menu = " ",
  },
  file = {
    regular = " ",
    regular_outline = " ",
    text = " ",
    plus = " ",
    edit = " ",
    move = "󱪓 ",
  },
}

M.tree = {
  angle = {
    down = " ",
    right = " ",
  },
  caret = {
    down = " ",
    right = " ",
  },
  light = {
    vertical = "│",
    triple_dash = "┆",
    split = "├╴",
    last = "╰╴",
  },
  heavy = {
    vertical = "┃",
    triple_dash = "┇",
  },
}

M.shape = {
  circle = {
    regular = " ",
    regular_outline = " ",
    dot = " ",
    plus = " ",
    minus = " ",
    check = " ",
    error = " ",
    info = " ",
    exclamation = " ",
    question = " ",
    up = " ",
    down = " ",
    left = " ",
    right = " ",
  },
  square = {
    regular = " ",
    regular_outline = " ",
    plus = " ",
    minus = " ",
    check = " ",
    error = " ",
    pen = " ",
  },
  triangle = {
    exclamation = " ",
  },
}

M.ui = {
  bug = " ",
  bulb = "󰌵 ",
  todo = M.shape.square.check,
  note = "󰎞 ",
  test = "󰙨 ",
  clock = " ",

  check = " ",
  search = " ",
  download = " ",
  gear = " ",
  sleep = "󰒲 ",
  eye = " ",
  link = "󰌷 ",

  heartbeat = "󰐰 ",
  unavailable = "",
  enabled = " ",
  disabled = " ",
  wifi = "󰖩 ",

  scissors = " ",
  tool = " ",
  broom = " ",
  code = " ",
  sparkles = " ",

  saw = "󰹈 ",

  header = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },

  spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
}

M.diagnostics = {
  error = M.shape.circle.error,
  warn = M.shape.triangle.exclamation,
  info = M.shape.circle.info,
  hint = M.ui.bulb,
  debug = M.ui.bug,
  trace = " ",
}

M.language = {
  lua = "󰢱 ",
  python = "󰌠 ",
  rust = "󱘗 ",
  neovim = " ", -- custom
  neovim_alt = " ", -- font logos
  vim = " ", -- devicons
  vim_alt = " ", -- custom
}

return M
