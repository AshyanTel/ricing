" Affichage du numéro
set number autoindent expandtab tabstop=2 shiftwidth=2

" Choix du thème de couleur
colorscheme raindrops

" Activation de la surbrillance pour la recherche
set hlsearch

" Activation du clipboard
set clipboard=unnamedplus 

" Activation de la correction syntaxique
" set spell spelllang=fr

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'rust-lang/rust.vim'
call plug#end()

if (has("termguicolors"))
  set termguicolors
endif

syntax enable
filetype plugin indent on
