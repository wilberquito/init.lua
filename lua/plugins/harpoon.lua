-- Harpoon: pin the 3-4 files of the task at hand and jump to them by number.
-- Bufferline cycles through EVERY open buffer; harpoon is the short list you
-- chose on purpose, and its order never changes under you.
--
-- Keys checked against every existing <leader> mapping: `a` and `1`-`4` were
-- free (`h` is gitsigns' hunk group). <C-e> natively scrolls one line, which
-- <C-d>/<C-u> already cover.
local function harpoon()
  return require("harpoon")
end

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      harpoon():setup()
    end,
    keys = {
      {
        "<leader>a",
        function()
          harpoon():list():add()
        end,
        desc = "Harpoon: add file",
      },
      {
        "<C-e>",
        function()
          harpoon().ui:toggle_quick_menu(harpoon():list())
        end,
        desc = "Harpoon: menu",
      },
      { "<leader>1", function() harpoon():list():select(1) end, desc = "Harpoon: file 1" },
      { "<leader>2", function() harpoon():list():select(2) end, desc = "Harpoon: file 2" },
      { "<leader>3", function() harpoon():list():select(3) end, desc = "Harpoon: file 3" },
      { "<leader>4", function() harpoon():list():select(4) end, desc = "Harpoon: file 4" },
    },
  },
}
