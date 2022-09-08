set number
set relativenumber
set mouse=r
set showcmd
set encoding=utf-8
set showmatch
set ignorecase
syntax enable

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'

cal plug#end()

nnoremap <C-f> :Files<Cr>
nnoremap <C-p> :GFiles<Cr>
map <esc> :noh<CR>
map <C-t> :NERDTreeToggle<Cr>

