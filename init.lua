-- Leader key is a space
vim.g.mapleader = " "

-- Setup globals that should always be around
-- See `./lua/globals
require "globals.options"
require "globals.remaps"

require "lsp.lsp"

require 'plugins.packer'

require "clipboard"

require 'plugins.packer'
