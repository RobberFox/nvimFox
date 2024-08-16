return {
	{
		'folke/tokyonight.nvim',
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			vim.cmd.colorscheme 'tokyonight-night'
			vim.cmd.hi 'Comment gui=none'
		end,
	},
	{
		'echasnovski/mini.statusline',
		config = function()
			require('mini.statusline').setup() -- you can write a helper variable `local statusline = require 'mini.statusline'`
			require('mini.statusline').section_location = function() -- and write `statusline.section_location` instead
				return '%l:%L %-2v' -- formatting ruler as LINE:TOTAL COLUMN
			end
		end,
	},
	{ 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } }, -- Highlight todo, notes, etc in comments
}
