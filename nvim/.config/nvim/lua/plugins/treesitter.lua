return {
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		'andymass/vim-matchup',
		'RRethy/nvim-treesitter-endwise',
		{
			'nvim-treesitter/nvim-treesitter-context',
			opts = {
				enable = true,
				throttle = true,
			}
		}
	},
	cmd = { 'TSUpdate' },
	event = { 'BufReadPost', 'BufNewFile' },
	opts = {
		ensure_installed = 'all',
		ignore_install = { 'phpdoc' },
		highlight = {
			enable = true
		},
		indent = {
			enable = true
		},
		endwise = {
			enable = true,
		},
		matchup = {
			enable = true
		}
	}
}
