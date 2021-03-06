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
Plug 'leafgarland/typescript-vim'
Plug 'zxqfl/tabnine-vim'
Plug 'linkinpark342/xonsh-vim'
Plug 'rust-lang/rust.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'
Plug 'pechorin/any-jump.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'udalov/kotlin-vim'
Plug 'junegunn/fzf.vim'
Plug 'fiatjaf/neuron.vim'
Plug 'liuchengxu/vista.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'withgod/vim-sourcepawn'
call plug#end()

" remove annoying preview windows from youcompleteme/tabnine
set completeopt-=preview

" firenvim
let g:firenvim_config = {
\   'localSettings': {
\       '.*': {
\           'selector': 'textarea',
\           'takeover': 'never',
\       },
\   }
\}

" Enable syntax highlighting
syntax enable
let g:jsx_ext_required = 0

let g:ale_linters = {
\   'javascript': ['eslint', 'flow-language-server'],
\   'haskell': ['hlint', 'hdevtools'],
\   'go': ['gobuild'],
\   'python': ['pyflakes', 'mypy'],
\   'fish': [],
\   'typescript': ['eslint'],
\   'rust': ['cargo'],
\   'dart': ['dartanalyzer', 'analysis_server'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'html': ['prettier'],
\   'go': ['goimports'],
\   'python': ['black'],
\   'css': ['prettier'],
\   'vue': ['prettier'],
\   'rust': ['rustfmt'],
\   'dart': ['dartfmt'],
\   'scala': ['scalafmt']
\}

let g:ale_lint_on_save = 1
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

let g:ale_javascript_flow_ls_use_global = 0
let g:ale_javascript_eslint_use_global = 0

map err :ALENextWrap<CR>

" Theme
set t_Co=256
set background=dark
colorscheme nord
colorscheme challenger_deep
colorscheme oceanic_material

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

au BufNewFile,BufRead *.tpl :set ft=html
au BufNewFile,BufRead *.svelte :set ft=html
au BufNewFile,BufRead *.tera :set ft=html
au BufNewFile,BufRead *.tsx :set ft=typescript

" remove bad typescript stuff
let g:typescript_indent_disable = 1

" for airline to work
set laststatus=2

" vipsql
let g:vipsql_separator_enabled = 1
let g:vipsql_separator = '===================================================================='
vnoremap <leader>ssql :VipsqlSendSelection<CR>
nnoremap <leader>lsql :VipsqlSendCurrentLine<CR>
nnoremap <leader>fsql :VipsqlSendBuffer<CR>
nnoremap <leader>psql :VipsqlShell<CR>

" emmet
let g:user_emmet_settings = { 'indentation' : ' ' }

" make backspace work
set backspace=indent,eol,start

" remove autoindent, autocomment, autobizarrethings
filetype plugin off
filetype indent off
set noautoindent
set nosmarttab

" don't let the cursor be at the top or at the bottom
set scrolloff=10

" ESC removes the highlighted matches that bother me after I search something with /
nnoremap <esc> :noh<return><esc>
