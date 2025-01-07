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
			{ "<leader>ca", "<cmd>Calendar -first_day=monday<cr>"},
			{ "<localleader>y", "<cmd>Calendar -first_day=monday -view=year<cr>"},
		},
	},
}
