set number
set relativenumber
set mouse=r
syntax enable
set showcmd
set encoding=utf-8
set showmatch
set ignorecase

call plug#begin('~/.vim/plugged')

" Add comments using gcc
Plug 'tpope/vim-commentary'

" Status bar
Plug 'vim-airline/vim-airline'

" Fuzzy finder searcher
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Remembers pursor position
Plug 'farmergreg/vim-lastplace'
cal plug#end()

" " Search files using fzf
nnoremap <C-p> :GFiles<Cr>
map <esc> :noh<CR>

