return {
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
						-- Disable single file support to help with e.g. deno projects.
						single_file_support = false,
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
}
