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

				-- Taken in part from https://github.com/neovim/nvim-lspconfig#suggested-configuration
				-- Use an on_attach function to only map the following keys after the
				-- language server attaches to the current buffer
				local on_attach = function(client, bufnr)
					local map = vim.keymap.set

					-- Enable completion triggered by <c-x><c-o>
					vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

					-- Mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					map('n', '<Leader>aa', vim.lsp.buf.code_action, { buffer = bufnr, silent = true })
					map('n', '<Leader>ad', vim.lsp.buf.type_definition, { buffer = bufnr, silent = true })
					map('n', '<Leader>af', vim.lsp.buf.formatting, { buffer = bufnr, silent = true })
					map('n', '<Leader>ar', vim.lsp.buf.rename, { buffer = bufnr, silent = true })
					map('n', '<Leader>as', vim.lsp.buf.signature_help, { buffer = bufnr, silent = true })
					map('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, silent = true })
					map('n', '<Leader>wl', function() return print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { buffer = bufnr, silent = true })
					map('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, silent = true })
					map('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, silent = true })
					map('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, silent = true })
					map('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, silent = true })
					map('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, silent = true })
				end

				local opts = {
					on_attach = on_attach,
					flags = {
						-- This will be the default in neovim 0.7+
						debounce_text_changes = 150,
					}
				}

				lspconfig.setup_handlers({
					function(server)
						require('lspconfig')[server].setup(opts)
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
				require('telescope').setup {
					defaults = {
						file_ignore_patterns = { 'node_modules', '.git' },
						layout_config = {
							center = {
								prompt_position = "bottom"
							}
						},
						layout_strategy = 'center',
						mappings = {
							i = {
								['<esc>'] = require('telescope.actions').close
							},
						},
						preview = false, -- no previews
						vimgrep_arguments = {
							'rg',
							'--color=never',
							'--no-heading',
							'--with-filename',
							'--line-number',
							'--column',
							'--smart-case',
							'--hidden'
						},
					},
					extensions = {
						fzf = {
							fuzzy = true,                    -- false will only do exact matching
							override_generic_sorter = true,  -- override the generic sorter
							override_file_sorter = true,     -- override the file sorter
							case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
						}
					},
					pickers = {
						find_files = {
							find_command = { 'fd', '--type', 'file', '--hidden', '--exclude', '.git', '--strip-cwd-prefix' }
						},
					}
				}

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
				local sessions = vim.fn.stdpath('data')..'/sessions'
				if vim.fn.empty(vim.fn.glob(sessions)) > 0 then
					vim.fn.system({ 'mkdir', '-p', sessions })
				end

				require('mini.bufremove').setup()
				require('mini.comment').setup()
				require('mini.completion').setup()
				require('mini.pairs').setup()
				require('mini.sessions').setup({ directory = sessions })
				require('mini.surround').setup()
			end
		}

		-- The one true color scheme
		use { 'dracula/vim', as = 'dracula' }

		-- Status line
		use {
			'nvim-lualine/lualine.nvim',
			config = function()
				require('lualine').setup({
					options = {
						component_separators = '',
						icons_enabled = false,
						section_separators = '',
						theme = 'dracula'
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
