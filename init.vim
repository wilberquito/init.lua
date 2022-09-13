set number
set relativenumber
set mouse=r
set showcmd
set encoding=utf-8
set showmatch
set ignorecase
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

cal plug#end()

nnoremap <C-f> :Files<Cr>
nnoremap <C-p> :GFiles<Cr>
map <esc> :noh<CR>
map <C-t> :NERDTreeToggle<Cr>

