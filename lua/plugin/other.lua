return {
	{
		"terrastruct/d2-vim",
		ft = "d2",
	},

	{
		"Aasim-A/scrollEOF.nvim",
		opts = {},
	},

	{
		"itchyny/calendar.vim",
		keys = {
			{ "<leader>cl", "<cmd>Calendar -first_day=monday<cr>"},
			{ "<localleader>y", "<cmd>Calendar -first_day=monday -view=year<cr>"},
		},

		init = function()
			vim.g.calendar_cache_directory = "~/stellardriven/calendar.vim/"
		end
	},
	--{
	--	'Kicamon/markdown-table-mode.nvim',
	--	ft = "markdown",
	--	config = function()
	--		require('markdown-table-mode').setup()
	--	end
	--}
}
