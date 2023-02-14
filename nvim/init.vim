let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/bin/python'

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" vim-plug
set nocompatible
call plug#begin('~/.vim/plugged')
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'lukas-reineke/lsp-format.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'isRuslan/vim-es6'
Plug 'vim-scripts/fish-syntax'
Plug 'udalov/kotlin-vim'
Plug 'martingms/vipsql'
Plug 'junegunn/goyo.vim'
Plug 'linkinpark342/xonsh-vim'
Plug 'rust-lang/rust.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'withgod/vim-sourcepawn'
Plug 'nvim-lua/plenary.nvim'
Plug 'scalameta/nvim-metals'
Plug 'akinsho/toggleterm.nvim'
Plug 'rebelot/kanagawa.nvim'
call plug#end()

" Enable syntax highlighting
syntax enable
let g:jsx_ext_required = 0

" theme
set t_Co=256
set background=dark
colorscheme kanagawa

" set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" turn TAB into spaces
set expandtab

" 1 tab == 4 spaces
set shiftwidth=0 " match tabstop
set tabstop=4

" except on C files
autocmd Filetype c,cpp setlocal tabstop=8

" show these characters in place of tabs
set list
set listchars=tab:\|>

" for go syntax
set shell=bash
set rtp+=$GOROOT/misc/vim

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
-- null-ls (linters and formatters)
local null_ls = require("null-ls")

null_ls.setup {
  diagnostics_format = "[#{c}] #{m} (#{s})",
  sources = {
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.scalafmt,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.formatting.dart_format,
    null_ls.builtins.formatting.rustfmt.with({
      extra_args = function(params)
        local Path = require("plenary.path")
        local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")
        if cargo_toml:exists() and cargo_toml:is_file() then
            for _, line in ipairs(cargo_toml:readlines()) do
                local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
                if edition then
                    return { "--edition=" .. edition }
                end
            end
        end
        -- default edition when we don't find `Cargo.toml` or the `edition` in it.
        return { "--edition=2021" }
      end,
    }),
  },
  on_attach = require("lsp-format").on_attach
}

require("lsp-format").setup {}

-- nvim-treesitter
require("nvim-treesitter.configs").setup({
  -- playground = { enable = true },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  ensure_installed = "all",
  highlight = {
    enable = true,
    --disable = { "scala" },
  },
})

-- lspconfig stuff
local lspconfig = require('lspconfig')

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- see also the telescope settings as some of the lsp stuff will be done on telescope

-- Use a loop to conveniently call 'setup' on multiple servers
local custom_opts = {
  tsserver = {
    root_dir = lspconfig.util.root_pattern('tsconfig.json')
  },
  kotlin_language_server = {
    root_dir = lspconfig.util.root_pattern('build.gradle')
  }
}
for _, lsp in pairs({
  'gopls',
  'clangd',
  'flow',
  'jedi_language_server',
  'tsserver',
  'svelte',
  'rust_analyzer',
  'kotlin_language_server'
}) do
  local opts = {}
  local custom = custom_opts[lsp] or {}
  for k, v in pairs(custom) do
    opts[k] = v
  end
  lspconfig[lsp].setup(opts)
end

-- nvim-metals
metals_config = require("metals").bare_config()
metals_config.settings = {
  serverVersion = "latest.snapshot",
  -- useGlobalExecutable = true,
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl", "android", "androidx" },
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

-- status line copied from https://github.com/ckipp01/dots
vim.opt.statusline = [[%!luaeval('require("statusline").super_custom_status_line()')]]
-- vim.opt.winbar = [[%!luaeval('require("statusline").super_custom_winbar()')]]

-- cmd (autocomplete)
local cmp = require'cmp'
local compare = require'cmp.config.compare'
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
  },
  sorting = {
    comparators = {
      compare.exact,
      compare.score,
      function (a, b)
        if a:get_kind() == 5 and b:get_kind() == 2 then
          return true
        elseif a:get_kind() == 2 and b:get_kind() == 5 then
          return false
        end
        return nil
      end,
      compare.kind,
      compare.recently_used,
      compare.locality,
      compare.offset,
      compare.sort_text,
      compare.length,
      compare.order
    }
  }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['gopls'].setup { capabilities = capabilities }
require('lspconfig')['flow'].setup { capabilities = capabilities }

-- telescope setup
require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  }
}
require("telescope").load_extension("ui-select")
-- telescope (find files)
vim.api.nvim_set_keymap('n', '<C-p>', "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
vim.api.nvim_set_keymap('n', '<C-a>', "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
vim.api.nvim_set_keymap('n', '<C-n>', "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
vim.api.nvim_set_keymap('n', '<C-g>', "<cmd>lua require('telescope.builtin').oldfiles()<CR>", opts)
-- telescope lsp stuff
vim.api.nvim_set_keymap('n', '<C-s>', "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", opts)
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-e>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

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
  shell = '/usr/bin/fish'
})

---
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

" navigate between tabs
nnoremap H :BufferPrevious<CR>
nnoremap L :BufferNext<CR>

" move tab position
nnoremap <C-h> :BufferMovePrevious<CR>
nnoremap <C-l> :BufferMoveNext<CR>

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
