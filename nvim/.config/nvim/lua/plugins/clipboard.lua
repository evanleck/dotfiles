return {
	'AckslD/nvim-neoclip.lua',
	dependencies = {
		{ 'nvim-telescope/telescope.nvim' }
	},
	event = { 'BufReadPost', 'BufNewFile' },
	opts = {
		enable_persistent_history = false
	}
}
