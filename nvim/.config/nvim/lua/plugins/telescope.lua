return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-lua/popup.nvim' },
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
	},
	lazy = true,
	config = function()
		local telescope = require('telescope')
		local actions = require('telescope.actions')
		local config = require('telescope.config')

		-- Clone the default Telescope configuration
		local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

		-- Search in hidden files but not git.
		table.insert(vimgrep_arguments, '--hidden')
		table.insert(vimgrep_arguments, '--trim')
		table.insert(vimgrep_arguments, '--glob')
		table.insert(vimgrep_arguments, '!.git/*')

		telescope.setup({
			defaults = {
				file_ignore_patterns = { 'node_modules' },
				layout_config = {
					center = {
						prompt_position = 'bottom'
					}
				},
				layout_strategy = 'center',
				mappings = {
					i = {
						['<esc>'] = actions.close
					},
				},
				preview = false, -- no previews
				vimgrep_arguments = vimgrep_arguments,
			},
			pickers = {
				find_files = {
					find_command = { 'fd', '--type', 'file', '--strip-cwd-prefix', '--hidden' },
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,                    -- false will only do exact matching
					override_generic_sorter = true,  -- override the generic sorter
					override_file_sorter = true,     -- override the file sorter
					case_mode = 'smart_case',
				}
			}
		})

		require('telescope').load_extension('fzf')
	end
}
