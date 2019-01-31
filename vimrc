if $SHELL =~ 'fish'
  set shell='/bin/sh'
endif

" vim-plug
set nocompatible
call plug#begin('~/.vim/plugged')
Plug 'alunny/pegjs-vim'
Plug 'w0rp/ale'
Plug 'bling/vim-airline'
Plug 'kchmck/vim-coffee-script'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'isRuslan/vim-es6'
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
Plug 'sbdchd/neoformat'
Plug 'ambv/black'
Plug 'LnL7/vim-nix'
Plug 'zxqfl/tabnine-vim'
Plug 'scrooloose/nerdtree'
Plug 'reasonml-editor/vim-reason-plus'
call plug#end()

" Enable syntax highlighting
syntax enable
let g:jsx_ext_required = 0

let g:ale_linters = {
\   'javascript': ['eslint_d'],
\   'python': ['python3'],
\   'haskell': ['hlint', 'hdevtools'],
\   'go': ['gofmt', 'go mod', 'go build'],
\   'reason': ['ols']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['goimports'],
\   'reason': ['refmt']
\}

let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0

" neoformat
nnoremap <leader>ff :Neoformat<CR>

" prettier
nmap <Leader>pp <Plug>(Prettier)
let g:prettier#autoformat = 0
let g:prettier#exec_cmd_async = 0
let g:prettier#quickfix_enabled = 1
let g:prettier#quickfix_auto_focus = 0
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.html call prettier#Autoformat()

" black
let g:black_virtualenv = "/home/fiatjaf/.local/venvs/black"
autocmd BufWritePre *.py execute ':Black'

" nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeQuitOnOpen=1
nmap <Leader>n :NERDTreeFind<CR>

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

" remove clipboard stuff
set clipboard=exclude:.*

" yank to clipboard (even over ssh) with \y
vnoremap <silent><Leader>y "yy <Bar> :call system('xclip', @y)<CR>
