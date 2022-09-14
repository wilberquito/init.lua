" Shows line numbers
set number

" Shows number relative to current line
set relativenumber

set mouse=r

set showcmd

set encoding=utf-8

" Underlines matches
set showmatch

" Search is not case sensitive
set ignorecase

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Auto indent
set ai

" Smart inden
set si

" Wrap lines
set wrap

syntax enable

call plug#begin('~/.vim/plugged')

" Easy comments
Plug 'tpope/vim-commentary'

" Status bar
Plug 'vim-airline/vim-airline'

" Fuzzy finder searcher
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Set cursor in file last place
Plug 'farmergreg/vim-lastplace'

" File navigation
Plug 'scrooloose/nerdtree'

" Plugin for see a vertical line in each ident
Plug 'Yggdroot/indentLine'

" Closes pair at new open
Plug 'jiangmiao/auto-pairs'

" Svelte
Plug 'evanleck/vim-svelte'

" JS
Plug 'pangloss/vim-javascript'

" Intellisense engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Dummy text of loremipsum
Plug 'vim-scripts/loremipsum'

cal plug#end()

nnoremap <C-f> :Files<Cr>
nnoremap <C-p> :GFiles<Cr>
map <esc> :noh<CR>
map <C-t> :NERDTreeToggle<Cr>

" Quit nerdtree when file has been open
let NERDTreeQuitOnOpen=1
