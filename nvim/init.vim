call plug#begin('~/.local/share/nvim/plugged')

" core
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'w0rp/ale'
Plug 'szw/vim-tags'
Plug 'Shougo/deoplete.nvim'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'skywind3000/asyncrun.vim'
Plug 'pedsm/sprint'

" fuzzy finding
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" theming
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'

" language specific
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'deoplete-plugins/deoplete-tag'
Plug 'sebastianmarkow/deoplete-rust'
" if installing tern gives an error do it manually with sudo
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

call plug#end()

let mapleader = ','

syntax on
filetype plugin indent on
colorscheme gruvbox
set background=dark

" set spellsuggest=best,10
" set spell spelllang=en_gb
set nobackup
set noswapfile
set nocompatible
set encoding=UTF-8
set number
set relativenumber
set splitbelow
set splitright
set cursorline
set mouse=a
set noexpandtab
set wrap
set linebreak
set smartindent
set showcmd
set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus
set colorcolumn=80

" Permanent undo 
set undodir=~/.vimdid
set undofile

" Writeroom things [Goyo]
let g:limelight_conceal_ctermfg = 'gray'
nnoremap <leader>g :Goyo<Return>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" lightline
let g:lightline = {'colorscheme' : 'seoul256'}

" NERDcommenter settings
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
map <space>c <plug>NERDCommenterToggle

" Deoplete
let g:deoplete#enable_at_startup = 1
" for making tab work for autocomplete list
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" remapping the splits from ctrl+w + direction ==> ctrl + directions
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnorema <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

" ale bindings 
nmap <silent> gE <Plug>(ale_previous_wrap)
nmap <silent> ge <Plug>(ale_next_wrap)

" Vimux bindings

function! VimuxSlime()
 call VimuxSendText(@v)
 call VimuxSendKeys("Enter")
endfunction

map <space>vp :VimuxPromptCommand<CR>
map <space>vl :VimuxRunLastCommand<CR>
map <space>vq :VimuxCloseRunner<CR>
map <space>vi :VimuxInspectRunner<CR>

vmap <space>vs "vy :call VimuxSlime()<CR>
nmap <space>vs vip<space>vs<CR>

" Sprint
nnoremap <f5> :Sprint<CR>

" fzf
nmap <space>f :Files<Return>
nmap <space>t :Tags<Return>
nmap <space>b :Buffer<Return>
nmap <space>l :Lines<Return>
let g:fzf_tags_command = 'ctags -R'

"" LANGUAGE SPECIFICS
" RUST
let g:deoplete#sources#rust#racer_binary='/home/firaaz/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/firaaz/Downloads/rust_bin/rust/src'
let g:deoplete#sources#rust#documentation_max_height=20
