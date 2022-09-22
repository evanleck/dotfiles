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

map('n', '<Leader>/', function() return require('telescope.builtin').live_grep() end)
map('n', '<Leader><Leader>', function() return require('telescope.builtin').find_files({ hidden = true }) end)
map('n', '<Leader>sb', function() return require('telescope.builtin').current_buffer_fuzzy_find() end)

-- Files
map('n', '<Leader>fm', ':Rename<Space>')
map('n', '<Leader>fD', ':Delete<CR>', { silent = true })
map('n', '<Leader>fs', ':w<CR>', { silent = true })

-- Quickfix
map('n', '<Leader>cN', ':cnewer<CR>', { silent = true })
map('n', '<Leader>cP', ':colder<CR>', { silent = true })
map('n', '<Leader>ck', ':cclose<CR>', { silent = true })
map('n', '<Leader>cn', ':cn<CR>', { silent = true })
map('n', '<Leader>co', ':copen<CR>', { silent = true })
map('n', '<Leader>cp', ':cp<CR>', { silent = true })

-- Buffers
map('n', '<Leader>,', function() return require('telescope.builtin').buffers() end)
map('n', '<Leader>bb', function() return require('telescope.builtin').buffers() end)
map('n', '<Leader>bd', ':Bdelete<cr>', { silent = true })

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
