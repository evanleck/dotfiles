return {
	'catppuccin/nvim',
	name = 'catppuccin',
	lazy = false,
	priority = 1000,
	opts = {
		flavour = 'mocha',
		integrations = {
			gitsigns = true,
			lualine = true,
			mason = true,
			mini = true,
			nvimtree = true,
			treesitter_context = true,
			treesitter = true,
			telescope = true
		}
	},
	config = function()
		vim.cmd.colorscheme('catppuccin')
	end
}
