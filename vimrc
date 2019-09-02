if $SHELL =~ 'fish'
  set shell='/bin/sh'
endif

" vim-plug
set nocompatible
call plug#begin('~/.vim/plugged')
Plug 'w0rp/ale'
Plug 'bling/vim-airline'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'isRuslan/vim-es6'
Plug 'wavded/vim-stylus'
Plug 'vim-scripts/fish-syntax'
Plug 'martingms/vipsql'
Plug 'junegunn/goyo.vim'
Plug 'vito-c/jq.vim'
Plug 'LnL7/vim-nix'
Plug 'zxqfl/tabnine-vim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'linkinpark342/xonsh-vim'
Plug 'rust-lang/rust.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'
Plug 'mattn/emmet-vim'
call plug#end()

" Enable syntax highlighting
syntax enable
let g:jsx_ext_required = 0

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'haskell': ['hlint', 'hdevtools'],
\   'go': ['gofmt', 'go mod', 'go build'],
\   'python': ['pyflakes'],
\   'fish': [],
\   'rust': ['cargo']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['goimports'],
\   'reason': ['refmt'],
\   'python': ['black'],
\   'javascript': ['prettier'],
\   'rust': ['rustfmt']
\}

let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 1000
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_use_global_executables = 1
let g:ale_echo_cursor = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_reasonml_refmt_executable = 'bsrefmt'

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

" .tpl, .tera, .svelte files as html
au BufNewFile,BufRead *.tpl :set ft=html
au BufNewFile,BufRead *.svelte :set ft=html
au BufNewFile,BufRead *.tera :set ft=html

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
