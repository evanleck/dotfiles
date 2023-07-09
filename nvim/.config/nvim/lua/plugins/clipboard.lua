return {
	'AckslD/nvim-neoclip.lua',
	dependencies = {
		{ 'kkharji/sqlite.lua' },
		{ 'nvim-telescope/telescope.nvim' }
	},
	event = { 'BufReadPost', 'BufNewFile' },
	opts = {
		enable_persistent_history = true
	}
}
