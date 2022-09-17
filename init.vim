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

" JS
Plug 'pangloss/vim-javascript'

" Intellisense engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Dummy text of loremipsum
Plug 'vim-scripts/loremipsum'

" Svelte
Plug 'evanleck/vim-svelte'

" Prettier
Plug 'prettier/vim-prettier', {'do': 'npm install'}

cal plug#end()

nnoremap <C-f> :Files<Cr>
nnoremap <C-p> :GFiles<Cr>
map <esc> :noh<CR>
map <C-t> :NERDTreeToggle<Cr>

" Quit nerdtree when file has been open
let NERDTreeQuitOnOpen=1

" Remap CoC autocompletation
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
au BufWritePre,TextChanged,InsertLeave *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.json PrettierAsync

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

