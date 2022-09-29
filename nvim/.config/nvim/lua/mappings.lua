local map = vim.keymap.set

-- Turn off linewise keys.
map('n', 'j', 'gj', { remap = true })
map('n', 'k', 'gk', { remap = true })

-- Doom Emacs kinda set the stage for this one...
map('n', '<Space>', '', { remap = true })

-- Copy to clipboard in normal, visual, select and operator modes
map('', '<Leader>y', '"+y')

-- Just let me paste for shit's sake.
map('i', '<C-v>', '<C-r>+')

-- Save for the dummies out there.
map('n', '<C-s>', ':write<cr>', { silent = true })

-- Get outta here highlights.
map('n', '<esc><esc>', ':nohlsearch<cr>', { silent = true })

-- File explorer.
map('n', '<Leader>op', ':NvimTreeToggle<CR>')

-- Clipboard
map('n', '<Leader>oc', function() require('telescope').extensions.neoclip.default() end)

-- Quitting
map('n', '<Leader>qa', ':qa<CR>', { silent = true })

-- Editing
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
map('n', '<Leader>do', vim.diagnostic.open_float, { silent = true })
map('n', '<Leader>dl', vim.diagnostic.setloclist, { silent = true })
map('n', '[d', vim.diagnostic.goto_prev, { silent = true })
map('n', ']d', vim.diagnostic.goto_next, { silent = true })

-- Finding
map('n', '<Leader>/', function() return require('telescope.builtin').live_grep() end)
map('n', '<Leader><Leader>', function() return require('telescope.builtin').find_files({ hidden = true }) end)
map('n', '<Leader>sb', function() return require('telescope.builtin').current_buffer_fuzzy_find() end)

-- Updates
map('n', '<Leader>up', function() return require('packer').sync() end)
map('n', '<Leader>ut', ':TSUpdate<CR>', { silent = true })

-- Files
map('n', '<Leader>fm', ':Rename<Space>')
map('n', '<Leader>fD', ':Delete<CR>', { silent = true })
map('n', '<Leader>fs', ':w<CR>', { silent = true })

-- Whitespace
-- Largely aped from
-- https://github.com/monkoose/neovim-setup/blob/0725b1ef821c58d02fba0fa3c688f0ebc69ecca8/lua/custom/unimpaired.lua#L1-L20
map('n', ']<Space>', function()
	local line = vim.fn.line(".")
	vim.api.nvim_buf_set_lines(0, line, line, true, { "" })
end, { silent = true })

map('n', '[<Space>', function()
	local line = vim.fn.line(".") - 1
	vim.api.nvim_buf_set_lines(0, line, line, true, { "" })
end, { silent = true })

-- Quickfix
map('n', '<Leader>cN', ':cnewer<CR>', { silent = true })
map('n', '<Leader>cP', ':colder<CR>', { silent = true })
map('n', '<Leader>cq', ':cclose<CR>', { silent = true })
map('n', '<Leader>cn', ':cn<CR>', { silent = true })
map('n', '<Leader>co', ':copen<CR>', { silent = true })
map('n', '<Leader>cp', ':cp<CR>', { silent = true })

-- Sessions
map('n', '<Leader>sd', function() return require('mini.sessions').select('delete') end, { silent = true })
map('n', '<Leader>so', function() return require('mini.sessions').select('read') end, { silent = true })
map('n', '<Leader>ss', function() return require('mini.sessions').select('write') end, { silent = true })

-- Buffers
map('n', '<Leader>,', function() return require('telescope.builtin').buffers() end)
map('n', '<Leader>bb', function() return require('telescope.builtin').buffers() end)
map('n', '<Leader>bd', function() return require('mini.bufremove').delete() end, { silent = true })

-- Splits and windows.
map('n', '<Leader>w=', ':wincmd =<CR>', { silent = true })
map('n', '<Leader>wq', ':q<CR>', { silent = true })
map('n', '<Leader>ws', ':sp<CR>', { silent = true })
map('n', '<Leader>wv', ':vs<CR>', { silent = true })
map('n', '<Leader>wo', ':only<CR>', { silent = true })

map('n', '<Leader>wl', ':wincmd l<CR>', { silent = true })
map('n', '<Leader>wh', ':wincmd h<CR>', { silent = true })
map('n', '<Leader>wj', ':wincmd j<CR>', { silent = true })
map('n', '<Leader>wk', ':wincmd k<CR>', { silent = true })

map('n', '<Leader>wL', ':wincmd L<CR>', { silent = true })
map('n', '<Leader>wH', ':wincmd H<CR>', { silent = true })
map('n', '<Leader>wJ', ':wincmd J<CR>', { silent = true })
map('n', '<Leader>wK', ':wincmd K<CR>', { silent = true })

-- Get between splits quicker and easier.
map('n', '<C-h>', ':wincmd h<CR>', { silent = true })
map('n', '<C-j>', ':wincmd j<CR>', { silent = true })
map('n', '<C-k>', ':wincmd k<CR>', { silent = true })
map('n', '<C-l>', ':wincmd l<CR>', { silent = true })

-- Visual stuff
map('v', '<Leader>s', ':sort<CR>', { silent = true })
