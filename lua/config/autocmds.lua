vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)

    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})


-- noice draws `:!cmd` output in its `split` view (see plugins/noice.lua). That
-- view is a float anchored to the bottom, `enter = false`, so it never takes
-- focus -- which means noice's `close.keys` / `close.events` never fire and the
-- panel would stay there forever, shrinking the editor after every shell
-- command. Dismiss it when you go back to work: the output is there to be read,
-- not to become part of the layout.
--
-- `router.dismiss()` is not usable: it walks EVERY view, including the cmdline
-- you are opening right now. Only the `split` ones are touched here.
vim.api.nvim_create_autocmd({ "CmdlineEnter", "InsertEnter" }, {
  callback = function()
    local ok, router = pcall(require, "noice.message.router")
    if not ok then
      return
    end
    for view in pairs(router.get_views()) do
      local opts = view._opts
      if opts and opts.view == "split" then
        view:dismiss()
        view:display()
      end
    end
  end,
})
