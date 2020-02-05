let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/bin/python'

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
