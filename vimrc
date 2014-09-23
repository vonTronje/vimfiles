" vim: nowrap fdm=marker
"  ---------------------------------------------------------------------------
"  Plugins
"  ---------------------------------------------------------------------------

silent! runtime bundles.vim
runtime plugins/bclose.vim

"  ---------------------------------------------------------------------------
"  General
"  ---------------------------------------------------------------------------

filetype plugin indent on
let mapleader = ","
let g:mapleader = ","
set modelines=0
set history=10000
set nobackup
set nowritebackup
set noswapfile
syntax enable
set autoread

"  ---------------------------------------------------------------------------
"  UI
"  ---------------------------------------------------------------------------

set title
set encoding=utf-8
set scrolloff=3
set autoindent
set smartindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
set norelativenumber
set undofile

" Auto adjust window sizes when they become current
" set winwidth=84
" set winheight=5
" set winminheight=5
" set winheight=999
"
" set splitbelow splitright
"
" if has('mouse')
"   set mouse=a
" endif

"  ---------------------------------------------------------------------------
"  Text Formatting
"  ---------------------------------------------------------------------------

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set nowrap
set textwidth=79
set formatoptions=n

" check to make sure vim has been compiled with colorcolumn support
" before enabling it
if exists("+colorcolumn")
  set colorcolumn=79
endif

"  ---------------------------------------------------------------------------
"  Mappings
"  ---------------------------------------------------------------------------

" Turn off arrow keys (this might not be a good idea for beginners, but it is
" the best way to ween yourself of arrow keys on to hjkl)
" http://yehudakatz.com/2010/07/29/everyone-who-tried-to-convince-me-to-use-vim-was-wrong/

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>"
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Searching / moving
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" Center screen when scrolling search results
nmap n nzz
nmap N Nzz

" ACK
" set grepprg=ack
" nnoremap <leader>a :Ack

" AG
" let g:ackprg = 'ag --nogroup --nocolor --column'
nnoremap <leader>a :Ag
let g:agprg="ag --ignore=tmp --ignore=log --ignore=db --ignore=bin --ignore=coverage --ignore='jquery*' --ignore='bootstrap*' --ignore='*foundation' --ignore='app/assets/javascripts/public/*.js' --column"


" Easy commenting
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

" Switch between buffers
noremap <tab> :bn<CR>
noremap <S-tab> :bp<CR>
" close buffer
nmap <leader>d :Bclose<CR>
" close all buffers
nmap <leader>D :bufdo bd<CR>

" Move between splits {{{
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

" Ignore some binary, versioning and backup files when auto-completing
set wildignore=.svn,CVS,.git,*.swp,*.jpg,*.png,*.gif,*.pdf,*.bak
" Set a lower priority for .old files
set suffixes+=.old

" pry
noremap <leader>p orequire 'pry'; binding.pry <Esc>

"  ---------------------------------------------------------------------------
"  Function Keys
"  ---------------------------------------------------------------------------

" Press F5 to toggle GUndo tree
nnoremap <F5> :GundoToggle<CR>

" indent file and return cursor and center cursor
map   <silent> <F6> mmgg=G`m^zz
imap  <silent> <F6> <Esc> mmgg=G`m^zz

"  ---------------------------------------------------------------------------
"  Plugins
"  ---------------------------------------------------------------------------

" eradicate all trailing whitespace all the time
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'

" AutoClose
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '#{': '}'}
let g:AutoCloseProtectedRegions = ["Character"]

" CtrlP
let g:ctrlp_mruf_relative = 1
let g:ctrlp_map = '<Leader>f'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_mruf_max = 0
let g:ctrlp_custom_ignore = '\v(public/assets/|tmp/cache/assets/)'

" Add settings for tabular
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Tabularize
if exists(":Tab")
  nmap <leader>a\| :Tab /\|<CR>
  vmap <leader>a\| :Tab /\|<CR>
  nmap <leader>a= :Tab /=<CR>
  vmap <leader>a= :Tab /=<CR>
  nmap <leader>a: :Tab /:\zs<CR>
  vmap <leader>a: :Tab /:\zs<CR>
endif

" Powerline
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12
" let g:Powerline_symbols='fancy'

" Airline
let g:airline_powerline_fonts = 1

"  ---------------------------------------------------------------------------
"  Language Mappings
"  ---------------------------------------------------------------------------

" Other files to consider Ruby
au BufRead,BufNewFile Gemfile,Rakefile,Thorfile,config.ru,Vagrantfile,Guardfile,Capfile set ft=

" CoffeeScript
let coffee_compile_vert = 1
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent

" SASS / SCSS
au BufNewFile,BufReadPost *.scss setl foldmethod=indent
au BufNewFile,BufReadPost *.sass setl foldmethod=indent
au BufRead,BufNewFile *.scss set filetype=scss

"  ---------------------------------------------------------------------------
"  Directories
"  ---------------------------------------------------------------------------

set backupdir=~/tmp,/tmp
set undodir=~/.vim/.tmp,~/tmp,~/.tmp,/tmp

" Ctags path (brew install ctags)
let Tlist_Ctags_Cmd = 'ctags'

" Make Vim use RVM correctly when using Zsh
" https://rvm.beginrescueend.com/integration/vim/
set shell=/bin/sh

" Finally, load custom configs
if filereadable($HOME . '.vimrc.local')
  source ~/.vimrc.local
endif

"  ---------------------------------------------------------------------------
"  MacVIM
"  ---------------------------------------------------------------------------

if has("gui_running")
  set guioptions-=T " no toolbar set guioptions-=m " no menus
  set guioptions-=r " no scrollbar on the right
  set guioptions-=R " no scrollbar on the right
  set guioptions-=l " no scrollbar on the left
  set guioptions-=b " no scrollbar on the bottom
  set guioptions=aiA
endif

"  ---------------------------------------------------------------------------
"  GnomeTerminal
"  ---------------------------------------------------------------------------
"
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

"  ---------------------------------------------------------------------------
"  Colors
"  ---------------------------------------------------------------------------
" let g:solarized_termcolors=256
set background=light
colorscheme solarized

let g:airline_theme='light'
"  ---------------------------------------------------------------------------
"  Misc
"  ---------------------------------------------------------------------------



" When vimrc, either directly or via symlink, is edited, automatically reload it
autocmd! bufwritepost .vimrc source %
autocmd! bufwritepost vimrc source %

function! Buflist()
    redir => bufnames
    silent ls
    redir END
    let list = []
    for i in split(bufnames, "\n")
        let buf = split(i, '"' )
        call add(list, buf[-2])
|   endfor
    return list
endfunction

function! Bdeleteonly()
    let list = filter(Buflist(), 'v:val != bufname("%")')
    for buffer in list
        exec "bdelete ".buffer
    endfor
endfunction

command! Bonly :silent call Bdeleteonly()

vmap <leader>em :call ExtractMethod()<CR>
" Extract Method
vmap <leader>em :call ExtractMethod()<CR>

function! ExtractMethod() range
  let args = split(inputdialog("Name of new method:"))

  let name = args[0]

  if len(args) > 1
    let param = "(".args[1].")"
  else
    let param = ""
  endif

  " wrap selection with def and end
  '<
  exe "normal! O\<BS>def \<Esc>"
  '>
  exe "normal! oend\<Esc>"

  " move extracted method to clipboard and under current method
  '<
  exe "normal! kV/\\<end\\>\<CR>d O".name. param
  '>
  exe "normal! k /def\<CR> k0O \<Esc>p"

  " move cursor to method name
  exe "normal! A" .name. param. "\<ESC>"

  "fix indentation
  exe "normal! V/\\<end\\>\<CR>=="

endfunction

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
" iterm2 escape codes: switch cursor shape for insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7""
