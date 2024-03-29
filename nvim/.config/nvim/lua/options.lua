local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local opt = vim.opt  -- to set options

-- Options
opt.background = 'dark'
opt.termguicolors = true

-- Because everything is UTF-8.
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

-- Backup, swap, and undo
local backup = fn.stdpath('cache') .. '/backup'
local swap = fn.stdpath('cache') .. '/swap'
local undo = fn.stdpath('cache') .. '/undo'

for _, directory in ipairs({ backup, swap, undo }) do
	if fn.isdirectory(directory) == 0 then
		fn.mkdir(directory)
	end
end

opt.backupdir = backup .. '//'
opt.directory = swap .. '//'
opt.undodir = undo .. '//'

opt.backup = true
opt.swapfile = true
opt.undofile = true

-- Lead me.
vim.g.mapleader = ' '

-- Disable line wrapping.
opt.wrap = false

-- Essential for filetype plugins.
cmd('filetype plugin indent on')

-- Because syntax matters.
cmd('syntax on')

-- Lines & line numbers
opt.cursorline = true
opt.number = true
opt.relativenumber = false

-- Indentation
opt.autoindent = true
opt.breakindent = true
opt.breakindentopt = 'shift:2'

-- Assorted options
opt.autoread = true                    -- Don't bother me when a file changes
opt.expandtab = false                  -- Tabs doggie
opt.fillchars = { vert = '│' }         -- Make the divider between splits a solid line.
opt.fixendofline = true                -- Always end with a new line.
opt.foldenable = false                 -- Start with all folds off.
opt.foldmethod = 'manual'              -- Force manual folding.
opt.formatoptions:append({ j = true, t = false }) -- Remove comments when joining lines and don't wrap my code lines.
opt.hidden = true                      -- Keep buffers around.
opt.hlsearch = true                    -- highlight matches
opt.ignorecase = true                  -- Ignore case by default.
opt.incsearch = true                   -- search as characters are entered
opt.laststatus = 2
opt.lazyredraw = true                  -- Don't update the screen while executing macros.
opt.list = true
opt.listchars = { tab = '› ', extends = '»', precedes = '«', nbsp = '·', trail = '·' } -- Unicode characters for various things
opt.modeline = false                   -- No need for in-buffer settings.
opt.mouse = 'nv'
opt.ruler = false                      -- Disable the ruler since we write our own statusline.
opt.shiftround = true                  -- Shift to certain columns, not just n spaces
opt.shiftwidth = 2                     -- Number of spaces to shift for autoindent or >,<
opt.shortmess:append({ c = true })
opt.showmatch = true                   -- highlight matching [{()}]
opt.showmode = false                   -- Airline does this for us.
opt.showtabline = 1                    -- Only show the tabline as needed.
opt.smartcase = true                   -- Lets you search for ALL CAPS
opt.softtabstop = 2                    -- Spaces 'feel' like tabs
opt.spell = true
opt.spelllang = 'en_us'
opt.splitbelow = true                  -- Split horizontal windows below to the current windows
opt.splitright = true                  -- Split vertical windows right to the current windows
opt.synmaxcol = 500                    -- Only syntax highlight to the 500th column by default.
opt.tabstop = 2                        -- The One True Tab
opt.textwidth = 80                     -- Turns out I kinda like 80...
