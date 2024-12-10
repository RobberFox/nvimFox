return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",  -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/stellardriven/",
				},
			},
		},
	},

	{
		"oflisback/obsidian-bridge.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},

		config = function() require("obsidian-bridge").setup() end,
		event = {
			"BufReadPre *.md",
			"BufNewFile *.md",
		},
		lazy = true,
	}
}
