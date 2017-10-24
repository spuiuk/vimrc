colorscheme torte

execute pathogen#infect()
syntax on
filetype plugin indent on

" Plugin: vim-colors-solarized
set background=dark
colorscheme solarized

" Plugin vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1

set scrolloff=1

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
