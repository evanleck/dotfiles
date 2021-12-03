-- Bootstrap packer.nvim
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
  execute 'packadd packer.nvim'
end

-- Plugins
require('packer').startup({
  function(use)
    -- Manage packer with packer
    use { 'wbthomason/packer.nvim' }

    -- LSP
    use {
      'neovim/nvim-lspconfig',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'williamboman/nvim-lsp-installer'
      },
      config = function()
        -- Taken directly from
        -- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
          local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
          local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

          --Enable completion triggered by <c-x><c-o>
          buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Mappings.
          local opts = { noremap = true, silent = true }

          -- See `:help vim.lsp.*` for documentation on any of the below functions
          buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
          buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
          buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
          buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
          buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
          buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
          buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
          buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
          buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
          buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
          buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
          buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
          buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
          buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
          buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
          buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
        local opts = { capabilities = capabilities, on_attach = on_attach }
        local lsp_installer = require('nvim-lsp-installer')

        -- Register a handler that will be called for all installed servers.
        -- Alternatively, you may also register handlers on specific server instances instead (see example below).
        lsp_installer.on_server_ready(function(server)
          -- This setup() function is exactly the same as lspconfig's setup function.
          -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
          server:setup(opts)
        end)
      end
    }

    -- Auto complete
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/vim-vsnip'
      },
      config = function()
        local cmp = require('cmp')

        cmp.setup({
          snippet = {
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body)
            end,
          },
          mapping = {
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ['<CR>'] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            })
          },
          sources = {
            { name = 'nvim_lsp' }
          }
        })
      end
    }

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require('nvim-treesitter.configs').setup {
          ensure_installed = 'maintained';
          highlight = {
            enable = true
          };
          indent = {
            enable = true
          }
        }
      end
    }

    -- Treesitter context
    use {
      'romgrk/nvim-treesitter-context',
      requires = { { 'nvim-treesitter/nvim-treesitter' } },
      config = function()
        require('treesitter-context').setup {
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
          throttle = true, -- Throttles plugin updates (may improve performance)
        }
      end
    }

    -- Telescope
    -- TODO Add this native plugin? https://github.com/nvim-telescope/telescope-fzf-native.nvim
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' }
      },
      config = function()
        local actions = require('telescope.actions')

        require('telescope').setup {
          defaults = {
            vimgrep_arguments = {
              'rg',
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
              '--smart-case',
              '--hidden'
            },

            file_ignore_patterns = { 'node_modules', '.git' },

            mappings = {
              i = {
                ["<esc>"] = actions.close
              },
            },
          }
        }
      end
    }

    -- Git signs
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require('gitsigns').setup()
      end
    }

    -- Editor
    use 'b3nj5m1n/kommentary'
    use 'moll/vim-bbye'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'

    -- Git
    use {
      'TimUntersberger/neogit',
      requires = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim'
      },
      config = function()
        require('neogit').setup {
          disable_commit_confirmation = true,
          integrations = {
            diffview = true
          }
        }
      end
    }

    -- The one true color scheme
    use { 'dracula/vim', as = 'dracula' }

    -- Status line
    use {
      'hoob3rt/lualine.nvim',
      requires = {
        'kyazdani42/nvim-web-devicons',
        opt = true
      },
      config = function()
        require('lualine').setup({
          options = {
            component_separators = '',
            icons_enabled = false,
            section_separators = '',
            theme = 'dracula'
          }
        })
      end
    }
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    },
    profile = {
      enable = false
    }
  }
})
