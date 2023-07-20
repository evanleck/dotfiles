return {
	'echasnovski/mini.nvim',
	event = { 'BufReadPost', 'BufNewFile' },
	config = function()
		require('mini.bufremove').setup()
		require('mini.comment').setup()
		require('mini.completion').setup()
		require('mini.pairs').setup()
		require('mini.surround').setup({
			mappings = {
				replace = 'sc'
			}
		})
		require('mini.trailspace').setup()
	end
}
