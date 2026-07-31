" ===== GENERAL =====
" Generals Settings
syntax enable
filetype plugin indent on
colorscheme catppuccin
let mapleader=','

" set visualbell
set formatoptions=tcroql
set autochdir
set encoding=utf-8
set number
set signcolumn=yes

" Tab settings
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Search settings
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set shell='fish'

" Buffer Settings
set clipboard=unnamedplus
set hidden
set noundofile
set backupdir=~/.vimtmp//,.
set directory=~/.vimtmp//,.
set nobackup
set noswapfile
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Line Fold
set foldmethod=indent
set nofoldenable

" IDE like integration, save all, and gently quit buffers
nnoremap <leader>w :wa<CR>
nnoremap <leader>q :bd<CR>
nnoremap <leader>x :wqa<CR>

" Improved navigation
set whichwrap+=<,>,h,l
" Paste doesn't move cursor.
nnoremap p p`[

" Better opening 
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap ` ``<Left>
inoremap < <><left>

"
inoremap <expr> <BS> DeletePair()

function! DeletePair()
    let col = col('.')
    let line = getline('.')

    if col > 1
        let prev = line[col - 2]
        let next = col <= len(line) ? line[col - 1] : ''

        if (prev == '(' && next == ')') ||
        \  (prev == '[' && next == ']') ||
        \  (prev == '{' && next == '}') ||
        \  (prev == '"' && next == '"') ||
        \  (prev == "'" && next == "'") ||
        \  (prev == '`' && next == '`') ||
        \  (prev == '<' && next == '>')
          return "\<Del>\<BS>"
        endif
    endif

    return "\<BS>"
endfunction

inoremap <expr> " getline('.')[col('.') - 1] == '"' ? "\<Right>" : "\"\"\<Left>"
inoremap <expr> ' getline('.')[col('.') - 1] == "'" ? "\<Right>" : "''\<Left>"
inoremap <expr> ) getline('.')[col('.') - 1] == ')' ? "\<Right>" : ")"
inoremap <expr> ] getline('.')[col('.') - 1] == ']' ? "\<Right>" : "]"
inoremap <expr> } getline('.')[col('.') - 1] == '}' ? "\<Right>" : "}"

if has("termguicolors")
    set termguicolors
endif

" Rules on certains files types
autocmd filetype bats set syntax=bash
autocmd filetype make setlocal noexpandtab
autocmd filetype c,cpp,rb,erb,java set tabstop=2 shiftwidth=2
autocmd filetype python set tabstop=4 shiftwidth=4

" +120 character line warning
augroup columnLimit
  autocmd!
  autocmd BufEnter,WinEnter,FileType cpp
        \ highlight ColumnLimit ctermbg=Red guibg=Red
  let columnLimit = 121
  let pattern =
        \ '\%<' . (columnLimit+1) . 'v.\%>' . columnLimit . 'v'
  autocmd BufEnter,WinEnter,FileType cpp
        \ let w:m1=matchadd('ColumnLimit', pattern, -1)
augroup END

autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" ===== PLUGINS =====
call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-commentary'
    Plug 'rust-lang/rust.vim'
    Plug 'dense-analysis/ale'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'rhysd/vim-lsp-ale'

    " Pandoc
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'

    " fzf integration
    Plug 'junegunn/fzf', { 'do': {  -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    
    let g:ale_linters = {'nix': []}
call plug#end()
