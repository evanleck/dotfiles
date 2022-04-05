-- TODO: Consider bootstrapping - https://github.com/wbthomason/packer.nvim#bootstrapping
--
require('plugins')
require('options')
require('mappings')

local vim = vim
local api = vim.api

function nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		api.nvim_command('augroup '..group_name)
		api.nvim_command('autocmd!')
		for _, def in ipairs(definition) do
			-- if type(def) == 'table' and type(def[#def]) == 'function' then
			-- 	def[#def] = lua_callback(def[#def])
			-- end
			local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
			api.nvim_command(command)
		end
		api.nvim_command('augroup END')
	end
end

local autocmds = {
	vimrc = {
		{ 'VimResized', '*', ':wincmd =' },
		{ 'BufWritePre', '*', 'call TrimTrailingWhitespace()' },
		{ 'BufWritePre', '*', 'call TrimTrailingEmptyLines()' }
	};
}

nvim_create_augroups(autocmds)
