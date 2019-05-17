" vim must be above version 8 and with python support

" used to see if vim-plug is installed if not installs it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" core
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'w0rp/ale'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim'
Plug 'szw/vim-tags'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'bkad/camelcasemotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'skywind3000/asyncrun.vim'
Plug 'pedsm/sprint'

" theming
Plug 'vim-airline/vim-airline'
Plug 'romainl/flattened'
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/limelight.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'

" language specific
Plug 'deoplete-plugins/deoplete-jedi'

call plug#end()

let mapleader = ','

syntax on
filetype plugin indent on
colorscheme flattened_dark

set term=screen-256color
set nocompatible
set encoding=UTF-8
set number
set relativenumber
set splitbelow
set splitright
set mouse=a
set noexpandtab
set wrap
set linebreak
set smartindent
set cursorline
set showcmd
set tabstop=4
set shiftwidth=4

" Syntastic Settings
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" Writeroom things [Goyo]
let g:limelight_conceal_ctermfg = 'gray'
nnoremap <leader>g :Goyo<Return>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

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

" Denite
nnoremap <space>v :Denite file/rec -default-action=vsplit<cr>
nnoremap <space>f :Denite file/rec -winheight=10 <cr>
nnoremap <space>s :Denite file/rec -default-action=split<cr>
nnoremap <space>l :Denite line -auto-preview<cr>
nnoremap <space>b :Denite buffer<CR>

" remapping the splits from ctrl+w + direction ==> ctrl + directions
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

" CamelCase
" call camelcasemotion#CreateMotionMappings('<leader>')
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie
sunmap w
sunmap b
sunmap e
sunmap ge

" Airline shit
let g:airline#extensions#tabline#enabled = 1
set noshowmode
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

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
