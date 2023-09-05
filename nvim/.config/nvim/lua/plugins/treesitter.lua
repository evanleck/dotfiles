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
	build = ':TSUpdate',
	opts = {
		auto_install = true,
		ensure_installed = {
			'bash',
			'c',
			'css',
			'dockerfile',
			'fish',
			'git_config',
			'git_rebase',
			'gitattributes',
			'gitcommit',
			'gitignore',
			'graphql',
			'hcl',
			'html',
			'java',
			'javascript',
			'jsdoc',
			'json',
			'lua',
			'luadoc',
			'make',
			'markdown',
			'markdown_inline',
			'python',
			'regex',
			'ruby',
			'rust',
			'scss',
			'sql',
			'terraform',
			'toml',
			'tsx',
			'typescript',
			'vim',
			'vimdoc',
			'xml',
			'yaml'
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false
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
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end
}
