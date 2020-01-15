let mapleader = ' '

"" Install the Coc extensions through CocInstall
" coc-tabnine
" coc-snippets
" coc-rls
" coc-tsserver
" coc-python
" coc-json
" coc-html
" coc-emmet

call plug#begin('~/.local/share/nvim/plugged')

" core
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ntpeters/vim-better-whitespace'
Plug 'editorconfig/editorconfig-vim'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'

" autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fuzzy finding
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" theming
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-highlightedyank'
Plug 'lifepillar/vim-solarized8'
Plug 'flrnd/plastic.vim'
Plug 'mkarmona/materialbox'
Plug 'itchyny/landscape.vim'

" tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'

" languages
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'neovimhaskell/haskell-vim'

call plug#end()

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

syntax on
filetype plugin indent on
set termguicolors
set background=dark
colorscheme landscape

set nocompatible
set mouse=a
set hidden
set ignorecase
set timeoutlen=300 ttimeoutlen=0
set nobackup
set showmode
set nowritebackup
set noswapfile
set wrap
set number
" set relativenumber
set splitbelow
set splitright
set noexpandtab
set linebreak
set autoindent
set showcmd
set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus
" set colorcolumn=83
set listchars=tab:▸\ ,eol:¬
set updatetime=300
set shortmess+=c
set signcolumn=yes
set encoding=UTF-8

" Theme
let g:landscape_highlight_todo = 1

" auto pairs
let g:AutoPairs = {'(':')', '[':']', '{':'}'}

function! CommandRemaps(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

"" ex-mode maps
call CommandRemaps('S', 'e ~/.config/nvim/init.vim')
call CommandRemaps('C', 'CocConfig')

" usual typos
call CommandRemaps('W', 'w')
call CommandRemaps('Wq', 'wq')
call CommandRemaps('qw', 'wq')

" Remove highlight after search by pressing esc
nnoremap <silent> <esc> :noh<cr><esc>

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

" fzf
nmap <leader>f :Files<Return>
nmap <leader>b :Buffer<Return>
nmap <leader>l :Lines<Return>

" nerdtree
" map <leader>t :NERDTreeToggle<CR>
" let g:NERDTreeIndicatorMapCustom = {
    " \ "Modified"  : "✹",
    " \ "Staged"    : "✚",
    " \ "Untracked" : "✭",
    " \ "Renamed"   : "➜",
    " \ "Unmerged"  : "═",
    " \ "Deleted"   : "✖",
    " \ "Dirty"     : "✗",
    " \ "Clean"     : "✔︎",
    " \ 'Ignored'   : '☒',
    " \ "Unknown"   : "?"
    " \ }

" whitespace
nmap <leader>w :ToggleWhitespace<CR>
nmap <leader>wc :StripWhitespace<CR>

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"""" COC settings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" rename the current word
nmap <leader>cr <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" use tab and S-Tab for navigation and Enter to select
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
