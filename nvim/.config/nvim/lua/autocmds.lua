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

api.nvim_create_augroup('colorscheme', { clear = true })
api.nvim_create_autocmd('ColorScheme', {
	group = 'colorscheme',
	pattern = '*',
	command = 'hi clear CursorLine'
})
