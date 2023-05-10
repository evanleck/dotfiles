local map = vim.keymap.set
local api = vim.api

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

-- Mason
map('n', '<Leader>om', ':Mason<CR>')

-- Clipboard
map('n', '<Leader>oc', function() require('telescope').extensions.neoclip.default() end)

-- Quitting
map('n', '<Leader>qa', ':qa<CR>', { silent = true })
map('n', '<Leader>qq', ':q<CR>', { silent = true })

-- LSP
api.nvim_create_augroup('lsp-keymap', { clear = true })
api.nvim_create_autocmd('LspAttach', {
	group = 'lsp-keymap',
	callback = function(args)
		local buffer = args.buf

		-- See `:help vim.lsp.*` for documentation on any of the below functions
		map('n', '<Leader>ca', vim.lsp.buf.code_action, { buffer = buffer, silent = true })
		map('n', '<Leader>cd', vim.lsp.buf.type_definition, { buffer = buffer, silent = true })
		map('n', '<Leader>cf', vim.lsp.buf.format, { buffer = buffer, silent = true })
		map('n', '<Leader>cr', vim.lsp.buf.rename, { buffer = buffer, silent = true })
		map('n', '<Leader>cs', vim.lsp.buf.signature_help, { buffer = buffer, silent = true })
		map('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = buffer, silent = true })
		map('n', '<Leader>wl', function() return print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { buffer = buffer, silent = true })
		map('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = buffer, silent = true })
		map('n', 'K', vim.lsp.buf.hover, { buffer = buffer, silent = true })
		map('n', 'gD', vim.lsp.buf.declaration, { buffer = buffer, silent = true })
		map('n', 'gd', vim.lsp.buf.definition, { buffer = buffer, silent = true })
		map('n', 'gr', vim.lsp.buf.references, { buffer = buffer, silent = true })
	end
})

-- Toggles
map('n', '<Leader>ts', function()
	vim.opt.spell = not(vim.opt.spell:get())
	vim.notify("spell: " .. tostring(vim.opt.spell:get()))
end)

-- Editing
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
map('n', '<Leader>do', vim.diagnostic.open_float, { silent = true })
map('n', '<Leader>dl', vim.diagnostic.setloclist, { silent = true })
map('n', '[d', vim.diagnostic.goto_prev, { silent = true })
map('n', ']d', vim.diagnostic.goto_next, { silent = true })

-- Finding
local telescope = require('telescope.builtin')

map('n', '<Leader>/', telescope.live_grep)
map('n', '<Leader><Leader>', telescope.find_files)
map('n', '<Leader>sb', telescope.current_buffer_fuzzy_find)
map('n', "<Leader>'", telescope.resume)

-- Buffers
map('n', '<Leader>,', telescope.buffers)
map('n', '<Leader>bb', telescope.buffers)
map('n', '<Leader>bd', function() return require('mini.bufremove').delete() end, { silent = true })

-- Updates
map('n', '<Leader>up', function() return require('packer').sync() end)
map('n', '<Leader>ut', ':TSUpdate<CR>', { silent = true })

-- Files
map('n', '<Leader>fm', ':Rename<Space>')
map('n', '<Leader>fD', ':Delete!<CR>', { silent = true })
map('n', '<Leader>fs', ':w<CR>', { silent = true })

-- Completion
map('i', '<Tab>', function()
	return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
end, { expr = true })

map('i', '<S-Tab>', function()
	return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
end, { expr = true })

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
map('n', '<Leader>ss', ':mksession!<CR>')
map('n', '<Leader>so', ':source Session.vim<CR>')

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
map('v', '<Leader>s', ':sort i<CR>', { silent = true })
