return {
	{
		"ibhagwan/fzf-lua",

		config = function()
			require("fzf-lua").setup({})

			local fzf = require("fzf-lua")
			local map = require('langmapper').map

			map("n", "<leader>sh", fzf.helptags)
			map("n", "<leader>sk", fzf.keymaps)
			map("n", "<leader>sf", fzf.files)
			map("n", "<leader>sg", fzf.live_grep)
			map("n", "<leader>sr", fzf.live_grep_resume)
			map("n", "<leader>s.", fzf.oldfiles)
			map("n", "<leader><leader>", fzf.buffers)
		end
	}
}
