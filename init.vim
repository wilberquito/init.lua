set encoding=utf-8

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" local vim configuration
set exrc

" line numbers
set relativenumber
set number

" search 
set nohlsearch
set incsearch

" fast swapping
set hidden

" stop err bells
set noerrorbells

" stop wrapping lines
set nowrap

" search ignoring case sensitive
set ignorecase

" handle buffers
set noswapfile
set nobackup

" scroll
set scrolloff=12

" give more space for displaying messages
set cmdheight=2

" show real time keyboard interaction
set showcmd

" syntax enable

call plug#begin('~/.vim/plugged')

" Easy comments
Plug 'tpope/vim-commentary'

" Telescope
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim'

Plug 'gruvbox-community/gruvbox'

" Status bar
Plug 'vim-airline/vim-airline'

" Set cursor in file last place
Plug 'farmergreg/vim-lastplace'

" File navigation
Plug 'scrooloose/nerdtree'

" Closes pair at new open
Plug 'jiangmiao/auto-pairs'

" JS
Plug 'pangloss/vim-javascript'

" Svelte
Plug 'evanleck/vim-svelte'
Plug 'othree/html5.vim'

" Close html tags
Plug 'alvan/vim-closetag'

" Intellisense engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Prettier
Plug 'prettier/vim-prettier', {'do': 'npm install'}

cal plug#end()


colorscheme gruvbox

let mapleader = " "

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Nerd Tree 
nnoremap <leader>t <cmd>NERDTreeToggle<cr>
let NERDTreeQuitOnOpen=1

" Vim Svelte option 
let g:svelte_indent_script = 0
let g:svelte_indent_style = 0

" CoC intellisense
" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" Prettier Settings
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat_require_pragma = 0
let g:closetag_filetypes = 'html,xhtml,phtml,svelte'
au BufWritePre *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.json PrettierAsync
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

