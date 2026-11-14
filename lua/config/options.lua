vim.opt.number = true -- Line numbers
vim.opt.numberwidth = 4 -- Columns for line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.scrolloff = math.floor(vim.o.lines / 4) -- Lines of context
vim.opt.sidescrolloff = math.floor(vim.o.columns / 6) -- Columns of context
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.wrap = false -- Disable line wrap
vim.opt.spelllang = { "en" }
vim.opt.textwidth = 0 -- Disable break line and column line by default.
vim.opt.syntax = "on"
vim.opt.winborder = "rounded"

vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.softtabstop = 2 -- Number of spaces tabs count for
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.shiftround = true -- Round indent
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.autoindent = true -- Enable autoindents
vim.opt.breakindent = true -- Enable breakindents
vim.opt.smartindent = true -- Insert indents automatically

vim.opt.grepformat = "%f:%l:%c:%m"
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep --no-messages --smart-case"
end

vim.opt.ignorecase = true -- Ignore case
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.hlsearch = true
vim.opt.incsearch = true -- Highlight pattern when searching

vim.opt.termguicolors = true -- True color support
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.colorcolumn = "" -- Disable break line and column line by default.
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.pumblend = 10 -- Popup menu transparency
vim.opt.winblend = 0 -- Floating window transparency
vim.opt.conceallevel = 3 -- Hide * markup for bold and italic

vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't backup before overwriting
vim.opt.swapfile = false -- Don't create swap files
vim.opt.updatetime = 300 -- Save swap file and trigger CursorHold
vim.opt.undofile = true
-- vim.opt.undotime = 300
vim.opt.undolevels = 10000
local undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undodir = undodir
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true -- Enable auto read
vim.opt.autowrite = true -- Enable auto write
vim.opt.diffopt:append("vertical") -- Vertical diff splits
vim.opt.diffopt:append("algorithm:patience") -- Better diff algorithm
vim.opt.diffopt:append("linematch:60") -- Better diff highlighting (smart line matching)
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer

vim.opt.hidden = true -- Enable modified buffers in background
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.path:append("**") -- Include subdirectories in search
vim.opt.selection = "inclusive"
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"
vim.opt.wildmenu = true -- Enable command-line completion menu
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.wildignorecase = true -- When set case is ignored when completing file names and directories

vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.splitkeep = "screen"

vim.opt.list = true -- Show some invisible characters
vim.opt.listchars:append("tab:󰌒 ") -- has to be 2 characters "tab: ", "tab:»·", "tab:󰌒 ", "tab: "
vim.opt.listchars:append("extends:") -- "extends:>"
vim.opt.listchars:append("trail:·")
-- vim.opt.listchars:append("eol:↴")

vim.opt.foldenable = true
vim.opt.fillchars:append("foldopen:")
vim.opt.fillchars:append("foldclose:")
-- vim.opt.fillchars:append("fold:⸱")
-- vim.opt.fillchars = {
--   foldopen = vim.g.icons.angle_down,
--   foldclose = vim.g.icons.angle_right,
--   -- fold = "⸱",
--   fold = " ",
--   foldsep = " ",
--   diff = "╱",
--   eob = " ",
-- }

vim.opt.formatoptions = "tcro/qnj" -- jcroqlnt, tcqj
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.isfname:append("@-@")

vim.opt.modeline = true
vim.opt.modelines = 5
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.showtabline = 0 -- Never show tabline

vim.g.loaded = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.g.health = { style = "float" }

vim.cmd.packadd("cfilter")
vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool")
