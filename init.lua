-- Leader key is a space
vim.g.mapleader = " "

-- Setup globals that should always be around
require 'globals/options'
require 'globals/remaps'
 
-- Install plugins
require 'packer/plugins'
