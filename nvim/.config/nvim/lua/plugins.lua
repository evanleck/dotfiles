-- Package manager
vim.cmd('packadd paq-nvim')           -- load the package manager
local paq = require('paq-nvim').paq   -- a convenient alias
paq { 'savq/paq-nvim', opt = true }   -- paq-nvim manages itself

-- Plugins
--
-- LSP
paq { 'neovim/nvim-lspconfig' }
paq { 'kabouzeid/nvim-lspinstall' }

-- Auto complete
paq { 'hrsh7th/nvim-compe' }

require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
    ultisnips = false;
  };
}

-- Treesitter
paq { 'nvim-treesitter/nvim-treesitter' }

local ts = require('nvim-treesitter.configs')

ts.setup {
  ensure_installed = 'maintained';
  highlight = {
    enable = true
  };
  indent = {
    enable = true
  }
}

-- Dependencies
paq { 'nvim-lua/popup.nvim' }
paq { 'nvim-lua/plenary.nvim' }

-- Telescope
-- TODO Add this native plugin? https://github.com/nvim-telescope/telescope-fzf-native.nvim
paq { 'nvim-telescope/telescope.nvim' }

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

-- Git signs
paq { 'lewis6991/gitsigns.nvim' }

require('gitsigns').setup()

-- Editor
paq { 'moll/vim-bbye' }
paq { 'tpope/vim-commentary' }
paq { 'tpope/vim-eunuch' }
paq { 'tpope/vim-surround' }
paq { 'tpope/vim-unimpaired' }

-- The one true color scheme
paq { 'dracula/vim', as = 'dracula' }

-- LSP
require('lspinstall').setup()

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

local servers = require('lspinstall').installed_servers()

for _, server in pairs(servers) do
  require('lspconfig')[server].setup { on_attach = on_attach }
end
