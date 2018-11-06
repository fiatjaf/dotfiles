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
Plug 'jasontbradshaw/pigeon.vim'
Plug 'mxw/vim-jsx'
Plug 'groenewege/vim-less'
Plug 'millermedeiros/vim-esformatter'
Plug 'wavded/vim-stylus'
Plug 'vim-scripts/fish-syntax'
Plug 'dart-lang/dart-vim-plugin'
Plug 'lambdatoast/elm.vim'
Plug 'martingms/vipsql'
Plug 'junegunn/goyo.vim'
Plug 'vito-c/jq.vim'
Plug 'prettier/vim-prettier'
Plug 'ambv/black'
call plug#end()

" Enable syntax highlighting
syntax enable
let g:jsx_ext_required = 0

" Syntastic specific options
let g:syntastic_aggregate_errors = 1
" python
let g:syntastic_python_checkers = ['python']
let g:syntastic_python_python_exec = 'python3'
" javascript
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
" haskell
let g:syntastic_haskell_checkers = ['hlint', 'hdevtools']
" go
let g:syntastic_go_checkers = ['go', 'golint']

" go.vim
let g:go_fmt_command = "goimports"

" prettier
nmap <Leader>pp <Plug>(Prettier)
let g:prettier#autoformat = 0
let g:prettier#exec_cmd_async = 0
let g:prettier#quickfix_enabled = 1
let g:prettier#quickfix_auto_focus = 0
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue call prettier#Autoformat()

" black
let g:black_virtualenv = "/home/fiatjaf/.local/venvs/black"
nmap <Leader>bl <Plug>(Black)
autocmd BufWritePre *.py execute ':Black'

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
