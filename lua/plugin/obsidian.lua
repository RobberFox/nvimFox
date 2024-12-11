return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",  -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
			"ibhagwan/fzf-lua",
			"nvim-treesitter/nvim-treesitter",
		},

		opts = require("custom.obsidian_opts"),
	},

	{
		"oflisback/obsidian-bridge.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},

		event = {
			"BufReadPre *.md",
			"BufNewFile *.md",
		},

		config = function() require("obsidian-bridge").setup() end,
		lazy = true,
	}
}
