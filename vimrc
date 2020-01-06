if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

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

"Add line numbers
nmap <Leader>l :setlocal number!<CR>
"Set paste mode ?
nmap <Leader>o :set paste!<CR>
"Clear search highlights
nmap <Leader>q :nohlsearch<CR>
"?
nmap <C-e> :e#<CR>
"Switch indent guide on/off
nmap <Leader>] :IndentGuidesToggle<CR>
"Syntax checker on/off
nmap <Leader>c :ALEToggle<CR>
"ctags - displays c functions in file
nmap <Leader>t :Tagbar<CR>
"Show indent lines. need line above
set listchars=tab:\|\ "A trailing space here is needed
nmap <Leader>g :set list!<CR>
"Git blame
nmap <Leader>b :Gblame!<CR>
"Enable c syntax highlighting
nmap <Leader>sc :set syntax=c<CR>
"Allow to write to file using sudo
cmap w!! w !sudo tee % >/dev/null

" My debug lines
map! <Leader>ds DEBUG(0, ("SP: %s:%d\n", __func__, __LINE__));

"Improve movement on wrapped lines
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>
nnoremap <Home> g<Home>
nnoremap <End> g<End>

" *** Plugins ***

" Call Pathogen first
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" Plugin: pull colorscheme from bundle
colorscheme desert256

" " Plugin: vim-colors-solarized
" set background=dark
" colorscheme solarized

" Plugin vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1

" Plugin w0rp/ale
let g:ale_enabled = 0

"Coc.nvim
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-tslint-plugin', 'coc-gocode', 'coc-prettier', 'coc-json', 'coc-python', 'coc-yaml', 'coc-html' ]

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Plugin gutentags
let g:gutentags_cache_dir = '~/.vim/gutentags'

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

" Plugin Lightline using tagbar
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode' ], [ 'gitbranch', 'filename', ], [ 'tagbar' ] ]
      \ },
      \ 'component': {
      \         'tagbar': '%{tagbar#currenttag("%s", "", "f")}',
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'gitbranch': 'gitbranch#name',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode'}
      \ }
function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction
function! LightLineFilename()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? g:lightline.fname :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction
function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction
function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction
function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
let g:tagbar_status_func = 'TagbarStatusFunc'
function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction
