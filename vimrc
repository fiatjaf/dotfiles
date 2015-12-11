" Enable syntax highlighting
syntax enable
let g:jsx_ext_required = 0

" Syntastic specific options
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python', 'mypy']
let g:syntastic_aggregate_errors = 1

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

" vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'lambdatoast/elm.vim.git'
Plugin 'alunny/pegjs-vim'
Plugin 'scrooloose/syntastic.git'
Plugin 'bling/vim-airline'
Plugin 'kchmck/vim-coffee-script.git'
Plugin 'hail2u/vim-css3-syntax.git'
Plugin 'ap/vim-css-color.git'
Plugin 'isRuslan/vim-es6.git'
Plugin 'fatih/vim-go.git'
Plugin 'mxw/vim-jsx.git'
Plugin 'groenewege/vim-less'
Plugin 'mindriot101/vim-yapf'
call vundle#end()
filetype plugin indent on

" for airline to work
set laststatus=2
