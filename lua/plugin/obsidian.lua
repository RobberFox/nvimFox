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
		lazy = true,
		event = {
			"BufReadPre *.md",
			"BufNewFile *.md",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
		--	obsidian_server_address = "https://127.0.0.1:27124",
		--	cert_path = "~/.ssl/obsidian.crt",
		},
	}
}
