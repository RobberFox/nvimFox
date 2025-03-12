return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},

	{
		"tpope/vim-fugitive",
		config = function()
			local map = require("langmapper").map

			map("n", "<leader>gs", vim.cmd.Git)
		end,
	}
}
