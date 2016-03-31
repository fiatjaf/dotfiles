if $SHELL =~ 'fish'
  set shell='/bin/sh'
endif

" vim-plug
set nocompatible
call plug#begin('~/.vim/plugged')
Plug 'lambdatoast/elm.vim'
Plug 'alunny/pegjs-vim'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'kchmck/vim-coffee-script'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'isRuslan/vim-es6'
Plug 'fatih/vim-go'
Plug 'mxw/vim-jsx'
Plug 'groenewege/vim-less'
Plug 'mindriot101/vim-yapf'
Plug 'millermedeiros/vim-esformatter'
Plug 'wavded/vim-stylus'
Plug 'vim-scripts/fish-syntax'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

" Enable syntax highlighting
syntax enable
let g:jsx_ext_required = 0

" Syntastic specific options
let g:syntastic_aggregate_errors = 1
" python
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python', 'mypy']
" javascript
let g:syntastic_javascript_checkers = ['standard']
" haskell
let g:syntastic_haskell_checkers = ['hlint', 'hdevtools']

" go.vim
let g:go_fmt_command = "goimports"

" Theme
set t_Co=256
set background=dark
colorscheme jellybeans

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" for go syntax
set shell=bash
set rtp+=$GOROOT/misc/vim

" .tpl files as html
au BufNewFile,BufRead *.tpl :set ft=html

" for airline to work
set laststatus=2

" remove autoindent, autocomment, autobizarrethings
filetype plugin off
filetype indent off
