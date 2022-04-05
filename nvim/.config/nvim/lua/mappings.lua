local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Turn off linewise keys.
map('n', 'j', 'gj', { noremap = false })
map('n', 'k', 'gk', { noremap = false })

-- Doom Emacs kinda set the stage for this one...
map('n', '<Space>', '', { noremap = false })
g.mapleader = ' '

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

map('n', '<Leader>/', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map('n', '<Leader><Leader>', "<cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>")
map('n', '<Leader>sb', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>")

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
map('n', '<Leader>,', "<cmd>lua require('telescope.builtin').buffers()<cr>")
map('n', '<Leader>bb', "<cmd>lua require('telescope.builtin').buffers()<cr>")
map('n', '<Leader>bd', ':Bdelete<cr>', { silent = true })
-- nnoremap <silent> <Leader>bl :BCommits<CR>
-- nnoremap <silent> <Leader>bt :BTags<CR>

-- Splits and windows.
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

--
-- From https://github.com/hrsh7th/nvim-compe
--
local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		return true
	else
		return false
	end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t '<C-n>'
		-- elseif vim.fn.call('vsnip#available', {1}) == 1 then
		--   return t '<Plug>(vsnip-expand-or-jump)'
	elseif check_back_space() then
		return t '<Tab>'
	else
		return vim.fn['compe#complete']()
	end
end

_G.s_tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t '<C-p>'
		-- elseif vim.fn.call('vsnip#jumpable', {-1}) == 1 then
		--   return t '<Plug>(vsnip-jump-prev)'
	else
		-- If <S-Tab> is not working in your terminal, change it to <C-h>
		return t '<S-Tab>'
	end
end

map('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
map('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
