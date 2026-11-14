-- Sources:
-- https://github.com/Allaman/nvim/blob/main/lua/vnext/config/mappings.lua

local function keymap(mode, lhs, rhs, opts)
  local default_opts = {
    silent = true,
    noremap = true,
  }

  local merged_opts = vim.tbl_deep_extend("force", default_opts, opts or {})

  vim.keymap.set(mode, lhs, rhs, merged_opts)
end

keymap({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
keymap("n", "<leader>qw", "<cmd>w<cr><cmd>qa<cr>", { desc = "Save and quit all" })
keymap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
keymap("n", "<leader>wq", "<cmd>q<cr>", { desc = "Quit window" })
keymap("n", "<leader>w<Right>", "<cmd>vsplit<cr>", { desc = "Split right" })
keymap("n", "<leader>w<Down>", "<cmd>split<cr>", { desc = "Split below" })
keymap("n", "<leader>fn", "<cmd>ene <bar> startinsert <cr>", { desc = "New file" })
keymap("n", "<leader>ol", "<cmd>Lazy<cr>", { desc = "Open Lazy" })

-- Move between windows using <ctrl> arrow keys
keymap({ "n", "i", "t" }, "<C-Up>", "<C-W><Up>", { desc = "Navigate up" })
keymap({ "n", "i", "t" }, "<C-Down>", "<C-W><Down>", { desc = "Navigate down" })
keymap({ "n", "i", "t" }, "<C-Left>", "<C-W><Left>", { desc = "Navigate left" })
keymap({ "n", "i", "t" }, "<C-Right>", "<C-W><Right>", { desc = "Navigate right" })

-- Resize window using <ctrl> <shift> arrow keys
keymap({ "n", "i", "t" }, "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap({ "n", "i", "t" }, "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap({ "n", "i", "t" }, "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap({ "n", "i", "t" }, "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move lines using the <shift> <up>/<down> keys
keymap("n", "<S-Down>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
keymap("n", "<S-Up>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
keymap("i", "<S-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
keymap("i", "<S-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
keymap("x", "<S-Down>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
keymap("x", "<S-Up>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

-- Indent lines using the <shift> <left>/<right> keys.
keymap("n", "<S-Right>", ">>", { desc = "Indent right" })
keymap("x", "<S-Right>", ">gv", { desc = "Indent right" })
keymap("n", "<S-Left>", "<<", { desc = "Indent left" })
keymap("x", "<S-Left>", "<gv", { desc = "Indent left" })
keymap("x", ">", ">gv")
keymap("x", "<", "<gv")

-- Append lines
keymap("n", "<leader><Down>", ":m .+1<cr><Up>mzJ`z", { desc = "Append current line to lower line" }) -- possibly <mz> redundant?
keymap("n", "<leader><Up>", "mzJ`z", { desc = "Append lower line to current line" }) -- possibly <mz> redundant?

-- Center after next/previous search result or page up/page down.
keymap("n", "n", "nzzzv", { desc = "Next" })
keymap("n", "N", "Nzzzv", { desc = "Previous" })
keymap({ "n", "x" }, "<C-d>", "<C-d>zzzv", { desc = "Half page down" })
keymap({ "n", "x" }, "<PageDown>", "<PageDown>zzzv", { desc = "Page down" })
keymap("i", "<C-d>", "<C-d>", { desc = "Half page down" })
keymap("i", "<PageDown>", "<PageDown>", { desc = "Page down" })
keymap({ "n", "x" }, "<C-u>", "<C-u>zzzv", { desc = "Half page up" })
keymap({ "n", "x" }, "<PageUp>", "<PageUp>zzzv", { desc = "Page up" })
keymap("i", "<C-u>", "<C-u>", { desc = "Half page up" })
keymap("i", "<PageUp>", "<PageUp>", { desc = "Page up" })

-- Move buffer
keymap("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- Yank to EOL
keymap("n", "Y", "y$", { desc = "Yank to end of line" })

-- Paste over currently selected text without yanking it.
keymap("x", "p", '"_dP', { desc = "Paste and keep register" })

-- Clear search with <esc> key
keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Better up/down
keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true })
keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true })

-- Faster folding
keymap("n", "-", "<cmd>foldclose<cr>", { desc = "Close fold" })
keymap("n", "+", "<cmd>foldopen<cr>", { desc = "Open fold" })

-- Disable q and Q.
-- keymap({ "n", "v", "s", "x" }, "q", "<NOP>")
-- keymap({ "n", "v", "s", "x" }, "Q", "<NOP>")
