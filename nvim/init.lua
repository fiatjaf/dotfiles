-- luacheck: globals vim
-- LuaFormatter off

-- install lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.filetype.add({ extension = { templ = "templ" } })

vim.opt.termguicolors = true
vim.opt.mouse = 'a'

require("globals")

-- options for vim.api.nvim_set_keymap
local noremap = { noremap = true, silent = true }

require("lazy").setup({
  'rebelot/kanagawa.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-ui-select.nvim',
  'NoahTheDuke/vim-just',
  'junegunn/goyo.vim',
  'linkinpark342/xonsh-vim',
  'nvim-lua/plenary.nvim',
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function ()
      local null_ls = require("null-ls")
      null_ls.setup {
        diagnostics_format = "[#{c}] #{m} (#{s})",
        sources = {
          null_ls.builtins.formatting.trim_whitespace,
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.lua_format,
          null_ls.builtins.formatting.zigfmt,
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
          null_ls.builtins.formatting.eslint,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.diagnostics.luacheck,
          null_ls.builtins.formatting.prettier
            .with({
              extra_filetypes = { "svelte" },
              disabled_filetypes = { "markdown", "markdown.mdx" }
            }),
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.ocamlformat,
          null_ls.builtins.diagnostics.fish,
          null_ls.builtins.formatting.dart_format,
          require("null-ls.helpers").make_builtin({
            name = "templ fmt",
            method = require("null-ls.methods").internal.FORMATTING,
            filetypes = { "templ" },
            generator_opts = {
              command = {"templ", "fmt"},
              to_stdin = true,
            },
            factory = require("null-ls.helpers").formatter_factory,
          })
        },
        on_attach = require("lsp-format").on_attach
      }
    end
  },
  {
    'lukas-reineke/lsp-format.nvim',
    config = function ()
      -- make lsps format code
      require("lsp-format").setup {}
    end
  },
  {
    'romgrk/barbar.nvim',
    init = function() vim.g.barbar_auto_setup = false end,
    config = function ()
      require('barbar').setup({
        animation = true,
        auto_hide = true,
        maximum_padding = 1,
        icons = {
          filetype = { enabled = false },
          button = '×',
          modified = {
            button = ''
          },
          separator = {
            left = '> '
          },
          inactive = {
            separator = {
              left = ''
            }
          },
        }
      })

      -- navigate through tabs
      vim.api.nvim_set_keymap('n', 'H', '<Cmd>BufferPrevious<CR>', noremap)
      vim.api.nvim_set_keymap('n', 'L', '<Cmd>BufferNext<CR>', noremap)
      -- move tab position
      vim.api.nvim_set_keymap('n', '<C-h>', '<Cmd>BufferMovePrevious<CR>', noremap)
      vim.api.nvim_set_keymap('n', '<C-l>', '<Cmd>BufferMoveNext<CR>', noremap)
      -- close buffer and open new terminal window
      vim.api.nvim_set_keymap('n', '<C-x>', '<Cmd>BufferClose<CR>', noremap)
      vim.api.nvim_set_keymap('n', '<C-b>c', '<Cmd>e term://fish<CR>', noremap)
    end
  },
  {
    'stevearc/oil.nvim',
    config = function ()
      require('oil').setup({ default_file_explorer = true })
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
      require("nvim-treesitter.configs").setup({
        -- playground = { enable = true },
        modules = {},
        ensure_installed = {},
        ignore_install = {},
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end
  },
  {
    'junegunn/vim-easy-align',
    config = function ()
      -- autoformat markdown tables `vip` to select the table, then \\ to format
      vim.cmd([[
        au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
      ]])
    end
  },
  {
    'martingms/vipsql',
    config = function ()
      vim.cmd([[
      let g:vipsql_separator_enabled = 1
      let g:vipsql_separator = '===================================================================='
      vnoremap <leader>ssql :VipsqlSendSelection<CR>
      nnoremap <leader>lsql :VipsqlSendCurrentLine<CR>
      nnoremap <leader>fsql :VipsqlSendBuffer<CR>
      nnoremap <leader>psql :VipsqlShell<CR>
      ]])
    end
  },
  {
    'akinsho/toggleterm.nvim',
    config = function ()
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
        shell = '/usr/bin/fish',
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function ()
      local lspconfig = require('lspconfig')

      lspconfig['templ'].setup({})
      lspconfig['gopls'].setup({})
      lspconfig['tailwindcss'].setup({
        filetypes = { "templ", "javascript", "typescript", "react", "svelte" },
        init_options = { userLanguages = { templ = "html" } },
      })
      lspconfig['clangd'].setup({})
      lspconfig['flow'].setup({})
      lspconfig['tsserver'].setup({
        root_dir = function (fname)
          return lspconfig.util.root_pattern('tsconfig.json')(fname)
            or (
                  not lspconfig.util.root_pattern('.flowconfig')(fname)
              and lspconfig.util.root_pattern('package.json')(fname)
            )
        end,
        single_file_support = false
      })
      lspconfig['denols'].setup({ root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc") })
      lspconfig['zls'].setup({})
      lspconfig['svelte'].setup({})
      lspconfig['rust_analyzer'].setup({})
      lspconfig['kotlin_language_server'].setup({ root_dir = lspconfig.util.root_pattern('build.gradle') })
      lspconfig['ocamllsp'].setup({})
      lspconfig['dartls'].setup({})
      lspconfig['lua_ls'].setup({
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            return
          end
          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT'
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                vim.env.HOME .. "/.local/share/nvim/lazy"
              }
            }
          })
        end,
        settings = {
          Lua = {}
        }
      })

      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', noremap)
      vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', noremap)
      vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', noremap)
      -- see also the telescope settings as some of the lsp stuff will be done on telescope
    end
  }
})

-- enable syntax highlighting
vim.opt.syntax = "on"

-- theme
vim.opt.compatible = false
vim.opt.background = "dark"
vim.cmd.colorscheme("kanagawa")

-- set utf8 as standard encoding
vim.opt.encoding="utf-8"

vim.opt.shiftwidth = 0 -- match tabstop
vim.opt.tabstop = 4 -- 1 tab == 4 spaces
vim.opt.expandtab = true -- turn TAB into spaces

-- show these characters in place of tabs
vim.opt.list = true
vim.opt.listchars = { tab = "|>" }

-- for airline to work
vim.opt.laststatus = 2

-- don't let the cursor be at the top or at the bottom
vim.opt.scrolloff = 10

-- remove autoindent, autocomment, autobizarrethings
vim.opt.autoindent = false
vim.opt.smarttab = false
vim.cmd([[
filetype plugin off
filetype indent off
]])

-- ESC removes the highlighted matches that bother me after I search something with /
vim.api.nvim_set_keymap('n', '<esc>', ':noh<return><esc>', noremap)

-- status line copied from https://github.com/ckipp01/dots
vim.opt.statusline = [[%!luaeval('require("statusline").super_custom_status_line()')]]
-- vim.opt.winbar = [[%!luaeval('require("statusline").super_custom_winbar()')]]

-- cmp (autocomplete)
local cmp = require('cmp')
local compare = require('cmp.config.compare')
local cmp_types = require('cmp.types.cmp')
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
vim.api.nvim_set_keymap('n', '<C-p>', "<cmd>lua require('telescope.builtin').find_files()<CR>", noremap)
vim.api.nvim_set_keymap('n', '<C-a>', "<cmd>lua require('telescope.builtin').live_grep()<CR>", noremap)
vim.api.nvim_set_keymap('n', '<C-n>', "<cmd>lua require('telescope.builtin').buffers()<CR>", noremap)
vim.api.nvim_set_keymap('n', '<C-g>', "<cmd>lua require('telescope.builtin').oldfiles()<CR>", noremap)
-- telescope lsp stuff
vim.api.nvim_set_keymap('n', '<C-s>', "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>",
  noremap)
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", noremap)
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", noremap)
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", noremap)
vim.api.nvim_set_keymap("n", "<C-e>", "<cmd>lua vim.lsp.buf.code_action()<CR>", noremap)

-- this is so we can prevent neovim from opening new neovim windows
-- inside neovim terminals
vim.env.IN_NEOVIM = 'yes'

-- LuaFormatter on
