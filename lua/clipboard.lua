if vim.fn.has("wsl") then
    vim.g.clipboard = {
        name = "clip.exe (Copy Only)",
        copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe"
        },
         paste = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe"
        },
        cache_enabled = true
    }
end

