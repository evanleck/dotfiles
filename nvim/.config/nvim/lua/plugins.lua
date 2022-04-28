-- Bootstrap packer.nvim
local execute = vim.api.nvim_command
local fn = vim.fn

-- Bootstrap packer.nvim if necessary.
--   https://github.com/wbthomason/packer.nvim#bootstrapping
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

-- Plugins
require('packer').startup({
	function(use)
		-- Manage packer with packer
		use { 'wbthomason/packer.nvim' }

		-- LSP
		use {
			'neovim/nvim-lspconfig',
			requires = {
				'hrsh7th/cmp-nvim-lsp',
				'williamboman/nvim-lsp-installer'
			},
			config = function()
				-- Taken directly from https://github.com/neovim/nvim-lspconfig#suggested-configuration

				-- Mappings.
				-- See `:help vim.diagnostic.*` for documentation on any of the below functions
				local opts = { noremap = true, silent = true }
				vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
				vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
				vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
				vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

				-- Use an on_attach function to only map the following keys
				-- after the language server attaches to the current buffer
				local on_attach = function(client, bufnr)
					-- Enable completion triggered by <c-x><c-o>
					vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

					-- Mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
					vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
					vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
					vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
					vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
					vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
					vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
					vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
					vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
					vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
					vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
					vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
				end

				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

				local opts = {
					capabilities = capabilities,
					on_attach = on_attach,
					flags = {
						-- This will be the default in neovim 0.7+
						debounce_text_changes = 150,
					}
				}

				-- Register a handler that will be called for all installed servers.
				-- Alternatively, you may also register handlers on specific server instances instead (see example below).
				require('nvim-lsp-installer').on_server_ready(function(server)
					-- This setup() function is exactly the same as lspconfig's setup function.
					-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
					server:setup(opts)
				end)
			end
		}

		-- Auto complete
		use {
			'hrsh7th/nvim-cmp',
			requires = {
				'hrsh7th/cmp-buffer',
				'hrsh7th/cmp-nvim-lsp'
			},
			config = function()
				local cmp = require('cmp')

				cmp.setup({
					mapping = {
						['<C-p>'] = cmp.mapping.select_prev_item(),
						['<C-n>'] = cmp.mapping.select_next_item(),
						['<C-d>'] = cmp.mapping.scroll_docs(-4),
						['<C-f>'] = cmp.mapping.scroll_docs(4),
						['<C-Space>'] = cmp.mapping.complete(),
						['<C-e>'] = cmp.mapping.close(),
						['<CR>'] = cmp.mapping.confirm {
							behavior = cmp.ConfirmBehavior.Replace,
							select = true,
						},
						['<Tab>'] = function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							else
								fallback()
							end
						end,
						['<S-Tab>'] = function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							else
								fallback()
							end
						end,
					},
					sources = {
						{ name = 'nvim_lsp' },
					},
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
			requires = { { 'nvim-treesitter/nvim-treesitter' } },
			config = function()
				require('treesitter-context').setup {
					enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
					throttle = true, -- Throttles plugin updates (may improve performance)
				}
			end
		}

		-- File tree
		use {
			'kyazdani42/nvim-tree.lua',
			config = function()
				vim.g.nvim_tree_show_icons = {
					git = 0,
					folders = 0,
					files = 0,
					folder_arrows = 0,
				}

				require('nvim-tree').setup({
					view = {
						side = 'left'
					}
				})
			end
		}

		-- FZF but Lua
		use {
			'ibhagwan/fzf-lua',
			config = function()
				require('fzf-lua').setup({
					files = {
						file_icons = false,
						git_icons = false
					},
					winopts = {
						preview = {
							default = 'bat_native',
							hidden = 'hidden'
						}
					},
					fzf_colors = {
						["fg"]          = { "fg", "CursorLine" },
						["bg"]          = { "bg", "Normal" },
						["hl"]          = { "fg", "Comment" },
						["fg+"]         = { "fg", "Normal" },
						["bg+"]         = { "bg", "CursorLine" },
						["hl+"]         = { "fg", "Statement" },
						["info"]        = { "fg", "PreProc" },
						["prompt"]      = { "fg", "Conditional" },
						["pointer"]     = { "fg", "Exception" },
						["marker"]      = { "fg", "Keyword" },
						["spinner"]     = { "fg", "Label" },
						["header"]      = { "fg", "Comment" },
						["gutter"]      = { "bg", "Normal" },
					},
				})
			end
		}

		-- Git signs
		use {
			'lewis6991/gitsigns.nvim',
			requires = {
				'nvim-lua/plenary.nvim'
			},
			config = function()
				require('gitsigns').setup()
			end
		}

		-- Org mode
		use 'axvr/org.vim'

		-- Editor
		use 'b3nj5m1n/kommentary'
		use 'editorconfig/editorconfig-vim'
		use 'farmergreg/vim-lastplace'
		use 'moll/vim-bbye'
		use 'tpope/vim-eunuch'
		use 'tpope/vim-surround'
		use 'tpope/vim-unimpaired'

		use {
			'windwp/nvim-autopairs',
			config = function()
				require('nvim-autopairs').setup({})
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

		-- Sync if we're bootstrapping.
		if packer_bootstrap then
			require('packer').sync()
		end
	end,
	config = {
		display = {
			open_fn = require('packer.util').float,
		},
		profile = {
			enable = false
		}
	}
})
