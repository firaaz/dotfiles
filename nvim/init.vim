let mapleader = ' '

"" Install the Coc extensions through CocInstall
" coc-explorer
" coc-tabnine
" coc-snippets
" coc-rls
" coc-tsserver
" coc-python
" coc-json
" coc-html
" coc-emmet
" coc-angular
" coc-texlab
" coc-template
" coc-todolist
" coc-vetur

call plug#begin('~/.local/share/nvim/plugged')

" core
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/indentLine'
Plug 'junegunn/goyo.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'majutsushi/tagbar'
Plug 'editorconfig/editorconfig-vim'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'dense-analysis/ale'
Plug 'chrisbra/SudoEdit.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fuzzy finding
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" theming
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-highlightedyank'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" colors
Plug 'mkarmona/materialbox'
Plug 'itchyny/landscape.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'dracula/vim'
Plug 'iCyMind/NeoSolarized'
Plug 'dguo/blood-moon', {'rtp': 'applications/vim'}
Plug 'morhetz/gruvbox'

" tmux
" Plug 'christoomey/vim-tmux-navigator'

" languages
Plug 'sheerun/vim-polyglot'
Plug 'neovimhaskell/haskell-vim'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'

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
" let ayucolor="dark"
let g:airline_theme='materialbox'
" let g:gruvbox_contrast_dark='hard'
colorscheme landscape

" for transpareacy 
" hi! Normal ctermbg=NONE guibg=NONE

set nocompatible
set number
set relativenumber
set mouse=a
set hidden
set ignorecase
set timeoutlen=500 ttimeoutlen=0
set nobackup
set nowritebackup
set noswapfile
set wrap
set splitbelow
set splitright
set expandtab
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
set updatetime=100
set noshowmode
set inccommand=nosplit
" set cursorline

" Theme

let g:indentLine_enabled = 0

let g:highlightedyank_highlight_duration = 150

" remapping the splits from ctrl+w + direction ==> ctrl + directions
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" Remove highlight after search by pressing esc
nnoremap <silent> <esc> :noh<cr><esc>

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

" Write sudo files
call CommandRemaps('w!!', 'SudoWrite')
call CommandRemaps('r!!', 'SudoRead')

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

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" fzf
nmap <leader>f :Files<Return>
nmap <leader>b :Buffer<Return>
nmap <leader>l :Lines<Return>

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"""" COC settings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>e :CocCommand explorer<CR>

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

inoremap <silent><expr> <c-space> coc#refresh()

" airline
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_left_sep           = ''
let g:airline_left_alt_sep       = ''
let g:airline_right_sep          = ''
let g:airline_right_alt_sep      = ''
let g:airline_symbols.crypt      = '🔒'
let g:airline_symbols.linenr     = '☰'
let g:airline_symbols.linenr     = '␊'
let g:airline_symbols.linenr     = '␤'
let g:airline_symbols.linenr     = '¶'
let g:airline_symbols.maxlinenr  = ''
let g:airline_symbols.maxlinenr  = '㏑'
let g:airline_symbols.branch     = '⎇'
let g:airline_symbols.paste      = 'ρ'
let g:airline_symbols.paste      = 'Þ'
let g:airline_symbols.paste      = '∥'
let g:airline_symbols.spell      = 'Ꞩ'
let g:airline_symbols.notexists  = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.branch     = ''
let g:airline_symbols.readonly   = ''
let g:airline_symbols.linenr     = '☰'
let g:airline_symbols.maxlinenr  = ''
let g:airline_symbols.dirty      = "⚡"

" language specfic
let g:ultisnips_python_style = 'google'

" term ( to use instead of tmux )
" tnoremap <Esc> <C-\><C-n>

" Maps ctrl-b + c to open a new tab window
nnoremap <C-b>c :tabnew +terminal<CR>
tnoremap <C-b>c <C-\><C-n>:tabnew +terminal<CR>

" Maps ctrl-b + " to open a new horizontal split with a terminal
nnoremap <C-b>" :new +terminal<CR>
tnoremap <C-b>" <C-\><C-n>:new +terminal<CR>

" Maps ctrl-b + % to open a new vertical split with a terminal
nnoremap <C-b>% :vnew +terminal<CR>
tnoremap <C-b>% <C-\><C-n>:vnew +terminal<cr>

" Tagbar
nmap <leader>tb :Tagbar<CR>
