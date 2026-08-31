" --- Initialization ---
let mapleader = " "
call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
call plug#end()

" --- General Settings ---
set nocompatible
filetype plugin indent on
syntax on
set number 
set tabstop=4 shiftwidth=4 expandtab smarttab
set termguicolors
set ignorecase smartcase
set scrolloff=8
set signcolumn=yes
set clipboard=unnamedplus
set encoding=utf-8
set nobackup nowritebackup
set updatetime=300

" --- UI ---
let g:gruvbox_contrast_dark = 'hard'
set background=dark
colorscheme gruvbox 
let g:airline_theme='gruvbox'

" --- Essential Keymaps ---
nnoremap <C-b> :NERDTreeToggle<CR>
" Diagnostics navigation
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" --- CoC.nvim Setup ---
" Helper functions
function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Completion Mappings
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" LSP Shortcuts
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" Commands
command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')
command! FoldAll :call CocActionAsync('fold')

" Auto-commands
autocmd CursorHold * silent call CocActionAsync('highlight')


