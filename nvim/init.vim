let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/bin/python'

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

if $SHELL =~ 'fish'
  set shell='/bin/sh'
endif

" vim-plug
set nocompatible
call plug#begin('~/.vim/plugged')
Plug 'w0rp/ale'
Plug 'romgrk/barbar.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'isRuslan/vim-es6'
Plug 'vim-scripts/fish-syntax'
Plug 'martingms/vipsql'
Plug 'junegunn/goyo.vim'
Plug 'linkinpark342/xonsh-vim'
Plug 'rust-lang/rust.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'fiatjaf/neuron.vim'
Plug 'rebelot/kanagawa.nvim'
Plug 'withgod/vim-sourcepawn'
Plug 'nvim-lua/plenary.nvim'
Plug 'scalameta/nvim-metals'
Plug 'akinsho/toggleterm.nvim'
call plug#end()

" cmp (autocomplete)
set completeopt=menu,menuone,noselect

" Enable syntax highlighting
syntax enable
let g:jsx_ext_required = 0

let g:ale_linters = {
\   'javascript': ['eslint', 'flow-language-server'],
\   'typescript': ['eslint'],
\   'haskell': ['hlint', 'hdevtools'],
\   'python': ['pyflakes', 'mypy'],
\   'scala': ['metals'],
\   'fish': [],
\   'rust': ['cargo'],
\   'dart': ['dart_analyze'],
\   'go': ['go build'],
\   'v': ['v'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascriptreact': ['eslint', 'prettier'],
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
\   'go': ['goimports', 'gofumpt'],
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

let g:ale_scala_metals_executable = '/home/fiatjaf/.local/share/coursier/bin/metals'

map err :ALENextWrap<CR>

" Theme
set t_Co=256
set background=dark
colorscheme kanagawa

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
" tnoremap <ESC> <C-\><C-n>

" LUA stuff
lua << endlua
-- nvim tree
require'nvim-tree'.setup {
  auto_close = true
}

-- lspconfig stuff
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- see also the telescope settings as some of the lsp stuff will be done on telescope

-- Use a loop to conveniently call 'setup' on multiple servers and
for _, lsp in pairs({ 'gopls', 'clangd', 'jedi_language_server', 'rust_analyzer' }) do
  require('lspconfig')[lsp].setup({
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  })
end

-- nvim-metals
metals_config = require("metals").bare_config()
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  showInferredType = true,
  useGlobalExecutable = false,
  superMethodLensesEnabled = true,
  showImplicitConversionsAndClasses = true,
}
metals_config.init_options.statusBarProvider = "on"
vim.cmd([[augroup lsp]])
vim.cmd([[autocmd!]])
vim.cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
vim.cmd([[autocmd FileType java,scala,sbt lua require("metals").initialize_or_attach(metals_config)]])
vim.cmd([[augroup end]])

-- status line copied from https://github.com/ckipp01/dots/blob/d1f85d93a800daabe0c6bbf32bbd4766429e2192/nvim/.config/nvim/init.lua#L83
require("statusline")
vim.opt.statusline = "%!luaeval('Super_custom_status_line()')"

-- cmd (autocomplete)
local cmp = require'cmp'
local cmp_types = require'cmp.types.cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp", priority = 10 },
    { name = "buffer" },
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i'}),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp_types.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp_types.SelectBehavior.Select }),
  }
})
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['metals'].setup { capabilities = capabilities }
require('lspconfig')['gopls'].setup { capabilities = capabilities }

-- telescope (find files)
vim.api.nvim_set_keymap('n', '<C-p>', "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
vim.api.nvim_set_keymap('n', '<C-a>', "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
vim.api.nvim_set_keymap('n', '<C-n>', "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
vim.api.nvim_set_keymap('n', '<C-g>', "<cmd>lua require('telescope.builtin').oldfiles()<CR>", opts)
-- telescope lsp stuff
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)

-- toggle-terminal
require("toggleterm").setup({
  -- size can be a number or function which is passed the current terminal
  size = function (term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
})
--
endlua

" open nvim-tree
nnoremap <C-t> :NvimTreeOpen<CR>

" barbar plugin with tmux-like things
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:true
let bufferline.maximum_padding = 1
let bufferline.icons = v:false
let bufferline.auto_hide = v:true
let bufferline.icon_separator_active = '> '
let bufferline.icon_separator_inactive = ''
let bufferline.icon_close_tab = '×'
let bufferline.icon_close_tab_modified = ''

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
nnoremap <C-b>c :e term://fish<CR>

let $IN_NEOVIM = 'yes'
