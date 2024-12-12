return {
	{
		"lervag/vimtex",
		lazy = false, -- we don"t want to lazy load VimTeX
		init = function()
			vim.g.vimtex_view_method = "zathura"

			require("nvim-treesitter.configs").setup({
				ensure_installed = { "markdown" },
				highlight = {
					enable = true,
					disable = { "latex" },
					additional_vim_regex_highlighting = { "latex", "markdown" },
				},
				--other treesitter settings
			})
		end
	},
}
