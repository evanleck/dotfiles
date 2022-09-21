local api = vim.api

api.nvim_create_augroup('resize', { clear = true })
api.nvim_create_autocmd('VimResized', {
	group = 'resize',
	pattern = '*',
	command = 'wincmd ='
})

api.nvim_create_augroup('trim', { clear = true })
api.nvim_create_autocmd('BufWritePre', {
	group = 'trim',
	pattern = '*',
	command = 'call TrimTrailingEmptyLines()'
})

api.nvim_create_augroup('dracula', { clear = true })
api.nvim_create_autocmd('ColorScheme dracula', {
	group = 'dracula',
	command = 'hi clear CursorLine'
})

require('plugins')
require('options')
require('mappings')
