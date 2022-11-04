vim.o.cursorline = true -- highlight current line
vim.o.cursorcolumn = true -- highlight current column 
vim.o.exrc = true  -- exec a local vimrc (like direnv)

-- Numbers
vim.o.number = true
vim.o.relativenumber = true  -- relative number in gutter

vim.o.nu = true  -- Indent current line number
vim.o.hlsearch = false  -- Don't highlight search
vim.o.incsearch = true  -- jump incrementally to search results
vim.o.hidden = true -- allow hidden buffers
vim.o.errorbells = false -- ding ding!
vim.o.wrap = false -- don't wrap long lines
vim.o.swapfile = false -- don't need no swap files!
vim.o.backup = false  -- ... or a backup!
vim.o.undodir = "~/.nvim/undodir"  -- sets where undo files land
vim.o.scrolloff = 8  -- scroll offwidth so it's not the very bottom
vim.o.colorcolumn = "80"  -- bar at 80 chars width
vim.o.signcolumn = "yes" -- always set the far left bar/column

vim.opt.termguicolors = true

vim.opt.errorbells = false

-- vim.o.nocompatible = true
vim.o.mouse = "a"  -- always enable mouse mode
vim.o.tabstop = 4  -- Tabs are 4 spaces: Reference - https://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
vim.o.softtabstop = 0
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
-- emoji is true by default but makes (n)vim treat all emoji as double width
-- which breaks rendering so we turn this off.
-- CREDIT: https://www.youtube.com/watch?v=F91VWOelFNE
vim.o.emoji = false
vim.o.ignorecase = true  -- ignore case when searching
vim.o.smartcase = true  -- Unless we explicitly use cases in search
vim.o.splitbelow = true  -- automagically h split going down
vim.o.splitright = true -- automagically v split going right
vim.opt.listchars = {  -- see hidden chars and their colors
    tab = "| ",
    eol = '¬',
    trail = '·'
}
vim.o.list = true
vim.o.updatetime = 100

vim.o.guicursor='i:blinkon1' -- let cursor blink in insert mode

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd[[
    augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
    augroup END
]]

vim.cmd[[
    " WSL yank support
    let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        augroup END
    endif
]]


