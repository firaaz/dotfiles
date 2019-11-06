let mapleader = ' '

"" Install the Coc extensions through CocInstall
" coc-tabnine
" coc-snippets
" coc-python
" coc-json
" coc-rls

call plug#begin('~/.local/share/nvim/plugged')
" core
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ntpeters/vim-better-whitespace'

" autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fuzzy finding
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" theming
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'lifepillar/vim-solarized8'
Plug 'flazz/vim-colorschemes'

" tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'

" languages
Plug 'sheerun/vim-polyglot'
call plug#end()

let g:solarized_termtrans=1
let g:solarized_extra_hi_groups=1

set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

syntax on
filetype plugin indent on
set termguicolors
colorscheme molokai
set background=dark

set mouse=a
set hidden
set timeoutlen=300 ttimeoutlen=0
set nobackup
set nowritebackup
set noswapfile
set wrap
set nocompatible
set encoding=UTF-8
set number
set relativenumber
set splitbelow
set splitright
set noexpandtab
set linebreak
set smartindent
set showcmd
set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus
set colorcolumn=83
set listchars=tab:▸\ ,eol:¬
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes


" for system clipboard support
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>
nnoremap <silent> p :call ClipboardPaste()<cr>p

" NERDcommenter settings
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
map <leader>c <plug>NERDCommenterToggle

" remapping the splits from ctrl+w + direction ==> ctrl + directions
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Vimux settings
function! VimuxSlime()
 call VimuxSendText(@v)
 call VimuxSendKeys("Enter")
endfunction

map <leader>vp :VimuxPromptCommand<CR>
map <leader>vl :VimuxRunLastCommand<CR>
map <leader>vq :VimuxCloseRunner<CR>
map <leader>vi :VimuxInspectRunner<CR>

vmap <leader>vs "vy :call VimuxSlime()<CR>
nmap <leader>vs vip<space>vs<CR>

" Sprint
nnoremap <f5> :Sprint<CR>

" fzf
nmap <leader>f :Files<Return>
nmap <leader>b :Buffer<Return>
nmap <leader>l :Lines<Return>

" nerdtree
map <leader>t :NERDTreeToggle<CR>

" whitespace
nmap <leader>w :ToggleWhitespace<CR>
nmap <leader>wc :StripWhitespace<CR>

"""" COC SETTINGS
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" rename the current word
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use :C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

" use tab for completion

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction
