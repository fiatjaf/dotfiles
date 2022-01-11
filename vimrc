let $IN_NEOVIM = 'yes'

if $SHELL =~ 'fish'
  set shell='/bin/sh'
endif

" vim-plug
set nocompatible
call plug#begin('~/.vim/plugged')
Plug 'w0rp/ale'
Plug 'romgrk/barbar.nvim'
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/chadtree', { 'branch': 'chad' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/vim-easy-align'
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
Plug 'linkinpark342/xonsh-vim'
Plug 'rust-lang/rust.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'
Plug 'dart-lang/dart-vim-plugin'
Plug 'udalov/kotlin-vim'
Plug 'junegunn/fzf.vim'
Plug 'fiatjaf/neuron.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'withgod/vim-sourcepawn'
Plug 'cheap-glitch/vim-v'
call plug#end()

" v
"autocmd BufRead,BufNewFile *.v set filetype=v

" Enable syntax highlighting
syntax enable
let g:jsx_ext_required = 0

let g:ale_linters = {
\   'javascript': ['eslint', 'flow-language-server'],
\   'typescript': ['eslint'],
\   'haskell': ['hlint', 'hdevtools'],
\   'python': ['pyflakes', 'mypy'],
\   'fish': [],
\   'rust': ['cargo'],
\   'dart': ['dart_analyze'],
\   'go': ['gofmt', 'go build'],
\   'v': ['v'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['prettier'],
\   'svelte': ['prettier'],
\   'python': ['black'],
\   'scala': ['scalafmt'],
\   'html': ['prettier'],
\   'rust': ['rustfmt'],
\   'dart': ['dart-format'],
\   'css': ['prettier'],
\   'vue': ['prettier'],
\   'go': ['goimports'],
\   'v': ['vfmt'],
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
let g:ale_javascript_prettier_use_global = 0

let g:ale_dart_format_executable = '/opt/flutter/bin/dart'
let g:ale_dart_analyze_executable = '/opt/flutter/bin/dart'

let g:ale_go_gofmt_options = '-s'

map err :ALENextWrap<CR>

" Theme
set t_Co=256
set background=dark
colorscheme challenger_deep

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
au BufNewFile,BufRead *.tera :set ft=html
au BufNewFile,BufRead *.tsx :set ft=typescript
au BufNewFile,BufRead *.svelte :set ft=svelte

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

" U reruns the syntax highlighting to unfuck my screen, as per https://vi.stackexchange.com/questions/2172/why-i-am-losing-syntax-highlighting-when-folding-code-within-a-script-tag
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

" markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

set termguicolors
set mouse+=a

" terminal mode to normal mode
tnoremap <C-b> <C-\><C-n>
tnoremap <ESC> <C-\><C-n>

" search files with fzf
nnoremap <C-p> :Files<CR>

" open tree
nnoremap <C-t> :CHADopen<CR>

" barbar plugin with tmux-like things
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.icons = v:false
let bufferline.auto_hide = v:true

nnoremap <C-b>h :BufferPrevious<CR>
nnoremap <C-b>l :BufferNext<CR>
nnoremap <C-b>j <C-w><C-j><CR>
nnoremap <C-b>k <C-w><C-k><CR>
nnoremap <C-b><C-h> :BufferMovePrevious<CR>
nnoremap <C-b><C-l> :BufferMoveNext<CR>
nnoremap <C-b>1 :BufferGoto 1<CR>
nnoremap <C-b>2 :BufferGoto 2<CR>
nnoremap <C-b>3 :BufferGoto 3<CR>
nnoremap <C-b>4 :BufferGoto 4<CR>
nnoremap <C-b>5 :BufferGoto 5<CR>
nnoremap <C-b>6 :BufferGoto 6<CR>
nnoremap <C-b>7 :BufferGoto 7<CR>
nnoremap <C-b>8 :BufferGoto 8<CR>
nnoremap <C-b>9 :BufferGoto 9<CR>
nnoremap <C-x> :BufferClose<CR>
nnoremap <C-b>c :new term://fish<CR>

" prevent closing with :q
cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>
