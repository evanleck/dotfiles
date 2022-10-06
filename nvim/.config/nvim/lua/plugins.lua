-- Bootstrap packer.nvim
local fn = vim.fn

-- Bootstrap packer.nvim if necessary.
--   https://github.com/wbthomason/packer.nvim#bootstrapping
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
	vim.cmd [[packadd packer.nvim]]
	packer_bootstrap = true
end

-- Plugins
require('packer').startup({
	function(use)
		-- Manage packer with packer
		use { 'wbthomason/packer.nvim' }

		-- LSP
		use {
			'williamboman/mason.nvim',
			requires = {
				'neovim/nvim-lspconfig',
				'williamboman/mason-lspconfig.nvim'
			},
			config = function()
				require('mason').setup()
				local lspconfig = require('mason-lspconfig')
				lspconfig.setup()
				lspconfig.setup_handlers({
					function(server)
						require('lspconfig')[server].setup({})
					end
				})
			end
		}

		-- Treesitter
		use {
			'nvim-treesitter/nvim-treesitter',
			requires = {
				'andymass/vim-matchup',
				'RRethy/nvim-treesitter-endwise'
			},
			config = function()
				require('nvim-treesitter.configs').setup {
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
			end
		}

		-- Treesitter context
		use {
			'lewis6991/nvim-treesitter-context',
			requires = { 'nvim-treesitter/nvim-treesitter' },
			config = function()
				require('treesitter-context').setup {
					enable = true,
					throttle = true,
				}
			end
		}

		-- File tree
		use {
			'kyazdani42/nvim-tree.lua',
			config = function()
				require('nvim-tree').setup({
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
				})
			end
		}

		-- Telescope
		use {
			'nvim-telescope/telescope.nvim',
			requires = {
				{ 'nvim-lua/plenary.nvim' },
				{ 'nvim-lua/popup.nvim' },
				{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
			},
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
		}

		-- Dress up some vim functions
		use { 'stevearc/dressing.nvim' }

		-- Git signs
		use {
			'lewis6991/gitsigns.nvim',
			requires = { 'nvim-lua/plenary.nvim' },
			config = function()
				require('gitsigns').setup()
			end
		}

		-- Org mode
		use 'axvr/org.vim'

		-- Editor
		use 'editorconfig/editorconfig-vim'
		use 'farmergreg/vim-lastplace'
		use 'tpope/vim-eunuch'

		-- All kinds of good stuff.
		use {
			'echasnovski/mini.nvim',
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
		}

		-- Colorscheme
		use {
			'catppuccin/nvim',
			as = 'catppuccin',
			config = function()
				vim.g.catppuccin_flavour = 'mocha'
				require('catppuccin').setup()

				vim.cmd.colorscheme('catppuccin')
			end
		}

		-- Status line
		use {
			'nvim-lualine/lualine.nvim',
			config = function()
				require('lualine').setup({
					options = {
						component_separators = '',
						icons_enabled = false,
						section_separators = '',
						theme = 'catppuccin'
					}
				})
			end
		}

		-- Clipboard management
		use {
			'AckslD/nvim-neoclip.lua',
			requires = {
				{ 'kkharji/sqlite.lua', module = 'sqlite' },
				{ 'nvim-telescope/telescope.nvim' }
			},
			config = function()
				require('neoclip').setup({
					enable_persistent_history = true
				})
			end
		}

		-- Sync if we're bootstrapping.
		if packer_bootstrap then
			require('packer').sync()
		end
	end,
	config = {
		display = {
			open_fn = require('packer.util').float,
		}
	}
})
