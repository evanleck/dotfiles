return {
	'nvim-tree/nvim-tree.lua',
	cmd = 'NvimTreeToggle',
	opts = {
		view = {
			side = 'left'
		},
		renderer = {
			icons = {
				show = {
					git = false,
					folder = false,
					file = false,
					folder_arrow = false,
				}
			}
		}
	}
}
