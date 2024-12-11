return {
	{
		"ibhagwan/fzf-lua",

		config = function()
			require("fzf-lua").setup({})

			local fzf = require("fzf-lua")
			vim.keymap.set("n", "<leader>sh", fzf.helptags)
			vim.keymap.set("n", "<leader>sk", fzf.keymaps)
			vim.keymap.set("n", "<leader>sf", fzf.files)
			vim.keymap.set("n", "<leader>sg", fzf.live_grep)
			vim.keymap.set("n", "<leader>sr", fzf.live_grep_resume)
			vim.keymap.set("n", "<leader>s.", fzf.oldfiles)
			vim.keymap.set("n", "<leader><leader>", fzf.buffers)
		end
	}
}
