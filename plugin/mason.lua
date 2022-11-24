local ok, config = pcall(require, "mason")
if not ok then
	return
end

config.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
