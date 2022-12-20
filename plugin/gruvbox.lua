local ok, config = pcall(require, "gruvbox")
if not ok then
    error("ERROR: gruvbox is not installed")
	return
end

config.setup({
  undercurl = true,
  underline = true,
  bold = false,
  italic = true,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
