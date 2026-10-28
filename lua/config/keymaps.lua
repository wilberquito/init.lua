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

-- Command-line window -> telescope pickers
--
-- `q:`, `q/` and `q?` open the command-line window (cmdline.txt, c_CTRL-F). That
-- window is NOT a float and cannot be made one: "The window is always full
-- width and is positioned just above the command-line" (cmdline.txt:1202). So
-- instead of a bottom split, the history goes to a centred, fuzzy picker.
--
-- <CR> in the picker loads the entry into the cmdline (noice's centred popup)
-- so you can still edit it before running it. `:q` is untouched.
--
-- Those mappings are timed: type `q`, wait more than `timeoutlen` (400ms) and
-- then the second key, and nvim has already given up on the mapping -- the
-- builtin wins. `timeout = false` would fix the timing but it breaks the `q`
-- that STOPS a macro recording: it stays pending as the prefix of `q:`, so the
-- next `:` opens the picker instead of the command line. So the fallback is
-- intercepted instead of fighting the clock:
--
--   slow `q:`     -> builtin command-line window      -> CmdwinEnter
--   slow `q/ q?`  -> a plain `/` search (the `q` is dropped) -> CmdlineEnter
--
-- `vim.on_key` only remembers "the last normal-mode key was a lonely q", so a
-- regular `/` search keeps working untouched.
local q_pending = false

vim.on_key(function(key)
  local mode = vim.fn.mode(1)
  if mode == "n" and key == "q" then
    q_pending = true
    vim.g.q_redirect = nil
    return
  end
  if q_pending and (key == ":" or key == "/" or key == "?") then
    vim.g.q_redirect = key
  else
    -- A stale flag would hijack the NEXT plain `/` after a fast `q/` mapping.
    vim.g.q_redirect = nil
  end
  q_pending = false
end)

vim.api.nvim_create_autocmd("CmdwinEnter", {
  callback = function()
    local kind = vim.fn.getcmdwintype()
    -- Leave the cmdwin before it is ever painted: the redirect happens here,
    -- not after a redraw, so there is no bottom split to see.
    vim.cmd("quit")
    vim.schedule(function()
      if kind == ":" then
        require("telescope.builtin").command_history()
      else
        require("telescope.builtin").search_history()
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("CmdlineEnter", {
  callback = function()
    local kind = vim.g.q_redirect
    vim.g.q_redirect = nil
    if (kind == "/" or kind == "?") and vim.fn.getcmdline() == "" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
      vim.schedule(function()
        require("telescope.builtin").search_history()
      end)
    end
  end,
})

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
