if $SHELL =~ 'fish'
  set shell='/bin/sh'
endif

" vim-plug
set nocompatible
call plug#begin('~/.vim/plugged')
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
Plug 'millermedeiros/vim-esformatter'
Plug 'wavded/vim-stylus'
Plug 'vim-scripts/fish-syntax'
Plug 'dart-lang/dart-vim-plugin'
Plug 'lambdatoast/elm.vim'
Plug 'martingms/vipsql'
call plug#end()

" Enable syntax highlighting
syntax enable
let g:jsx_ext_required = 0

" Syntastic specific options
let g:syntastic_aggregate_errors = 1
" python
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python', 'flake8']
" javascript
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
" haskell
let g:syntastic_haskell_checkers = ['hlint', 'hdevtools']
" go
let g:syntastic_go_checkers = ['go', 'golint']

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

" vipsql
let g:vipsql_separator_enabled = 1
let g:vipsql_separator = '===================================================================='
vnoremap <leader>ssql :VipsqlSendSelection<CR>
nnoremap <leader>lsql :VipsqlSendCurrentLine<CR>
nnoremap <leader>fsql :VipsqlSendBuffer<CR>
nnoremap <leader>psql :VipsqlShell<CR>

" make backspace work
set backspace=indent,eol,start

" remove autoindent, autocomment, autobizarrethings
filetype plugin off
filetype indent off

" don't let the cursor be at the top or at the bottom
set scrolloff=10

" tmux
set title
autocmd BufEnter * call system("tmux rename-window " . expand("%:t"))
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
autocmd VimLeavePre * call system("tmux setw automatic-rename")

let tmuxwindow = ""
autocmd VimEnter * let tmuxwindow = system("tmux display-message -p '#I' | tr -d '\040\011\012\015'")
autocmd BufWritePre * call system("tmux rename-window 'saving " . expand("%:t") . "'")
autocmd BufWritePost * let &titlestring = ' ' . expand("%:t")
autocmd BufWritePost * call system("tmux rename-window -t " . tmuxwindow . " " . expand("%:t"))
