if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

colorscheme desert256
syntax on
filetype plugin indent on
set scrolloff=1
" Move through text file as you search
set incsearch
set ignorecase
set smartcase
set hlsearch
set laststatus=2

" Key mappings
nmap \l :setlocal number!<CR>
nmap \o :set paste!<CR>
nmap \q :nohlsearch<CR>
nmap <C-e> :e#<CR>
nmap \] :IndentGuidesToggle<CR>
nmap \c :ALEToggle<CR>

" *** Plugins ***

" Call Pathogen first
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" " Plugin: vim-colors-solarized
" set background=dark
" colorscheme solarized

" Plugin vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1

" Plugin w0rp/ale
let g:ale_enabled = 0

if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif
