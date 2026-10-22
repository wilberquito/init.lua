local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

-- Moving content around without losing the selection
map("v", ">", ">gv", "Indent and keep selection")
map("v", "<", "<gv", "Outdent and keep selection")
map("x", "J", ":m '>+1<CR>gv=gv", "Move selection down")
map("x", "K", ":m '<-2<CR>gv=gv", "Move selection up")

-- Window navigation
map("n", "<C-h>", "<C-w>h", "Window left")
map("n", "<C-j>", "<C-w>j", "Window down")
map("n", "<C-k>", "<C-w>k", "Window up")
map("n", "<C-l>", "<C-w>l", "Window right")

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")

-- Keep the search results centered on screen
map("n", "n", "nzzzv", "Next match")
map("n", "N", "Nzzzv", "Previous match")

-- Save and close
map("n", "<leader>w", "<cmd>write<CR>", "Write buffer")
map("n", "<leader>q", "<cmd>quit<CR>", "Quit window")
map("n", "<leader>x", "<cmd>bdelete<CR>", "Close buffer")

-- Repeat the last f/t motion
map("n", "g;", ";;", "Repeat last find")

-- Diagnostics
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, "Next diagnostic")
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, "Previous diagnostic")

-- Clipboard: explicit mappings on purpose. Setting `clipboard=unnamedplus`
-- sends every yank to the OS, which over SSH (OSC 52) pays latency on each one.
map({ "n", "v" }, "<leader>y", '"+y', "Yank to OS clipboard")

local function paste_clipboard()
  local lines = vim.fn.getreg("+", 1, true)
  if #lines == 0 then
    return
  end

  -- Respect the clipboard's real shape. `"+p` pastes char-wise in the middle of
  -- the line when the text has no trailing newline (browsers, chat, git log),
  -- which mangles the buffer. This mirrors the register type instead.
  local regtype = vim.fn.getregtype("+")
  local kind = regtype:sub(1, 1) == "V" and "l"
    or (regtype:sub(1, 1) == "\22" and "b")
    or "c"

  -- nvim_put does not touch the unnamed register, so the last yank survives.
  vim.api.nvim_put(lines, kind, true, true)
end

map("n", "<leader>p", paste_clipboard, "Paste OS clipboard")
map("x", "<leader>p", '"+P', "Replace selection with OS clipboard")
