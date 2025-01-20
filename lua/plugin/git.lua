return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"tpope/vim-fugitive",
		config = function()
			local map = require("langmapper").map

			map("n", "<leader>gs", vim.cmd.Git)
		end,
	},
}
