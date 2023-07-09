-- Bootstrap lazy.nvim
--   https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath, })
end

vim.opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup({
	-- LSP
	{
		'williamboman/mason.nvim',
		dependencies = {
			'neovim/nvim-lspconfig',
			'williamboman/mason-lspconfig.nvim'
		},
		config = function()
			require('mason').setup()
			local lspconfig = require('mason-lspconfig')
			lspconfig.setup()
			lspconfig.setup_handlers({
				function(server)
					local options = {}

					-- This behaves almost exactly like the base configuration but omits
					-- ".git" to prevent mis-activating in e.g. a Deno project.
					--
					-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/tsserver.lua
					if server == 'tsserver' then
						options = {
							root_dir = function(fname)
								return require('lspconfig.util').root_pattern('tsconfig.json')(fname)
									or require('lspconfig.util').root_pattern('package.json', 'jsconfig.json')(fname)
							end
						}
					end

					require('lspconfig')[server].setup(options)
				end
			})
		end
	},

	-- Treesitter
	{
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
	},

	-- File tree
	{
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
	},

	-- Telescope
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			{ 'nvim-lua/plenary.nvim', lazy = true },
			{ 'nvim-lua/popup.nvim', lazy = true },
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', lazy = true }
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
						find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' },
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
	},

	-- Dress up some vim functions
	'stevearc/dressing.nvim',

	-- Git signs
	{
		'lewis6991/gitsigns.nvim',
		dependencies = { 'nvim-lua/plenary.nvim', lazy = true },
		event = { 'BufReadPost', 'BufNewFile' },
		config = true
	},

	-- Org mode
	'axvr/org.vim',

	-- Editor
	'farmergreg/vim-lastplace',
	'tpope/vim-eunuch',

	-- All kinds of good stuff.
	{
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
		end
	},

	-- Colorscheme
	{
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
	},

	-- Status line
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				component_separators = '',
				icons_enabled = false,
				section_separators = '',
				theme = 'catppuccin'
			}
		}
	},

	-- Clipboard management
	{
		'AckslD/nvim-neoclip.lua',
		dependencies = {
			{ 'kkharji/sqlite.lua', lazy = true },
			{ 'nvim-telescope/telescope.nvim', lazy = true }
		},
		event = { 'BufReadPost', 'BufNewFile' },
		opts = {
			enable_persistent_history = true
		}
	}
})
