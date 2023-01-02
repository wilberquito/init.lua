local ok, conf = pcall(require, "zen-mode")
if not ok then
    error("Error - zen mode plugin not found")
    return
end

conf.setup {
    window = {
        width = 95,
        options = {
            number = true,
            relativenumber = true,
        }
    },
}

vim.keymap.set("n", "<leader>zz", function()
    conf.toggle()
    vim.wo.wrap = false
end)

