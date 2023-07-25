local M = {}

-- This is currently only used for determining a decent name for automatic
-- session creation and restoration.
--
-- Turns something like "/Users/you/some/.directory or another" into
-- "some-directory-or-another".
function M.cwd()
	local cwd = vim.fn.getcwd()
	local home = vim.env.HOME

	-- Get the current working directory, minus the home directory.
	if cwd:find(home) then
		cwd = cwd:sub(cwd:find(home) + home:len() + 1)
	end

	-- Remove path separators and dots
	cwd = cwd:gsub("%A", "-"):gsub("-+", "-"):gsub("^-", "")

	return cwd
end

return M
