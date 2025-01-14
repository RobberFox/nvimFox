return {
	{
		"lervag/vimtex",
		lazy = false, -- we don"t want to lazy load VimTeX
		init = function()
			vim.g.vimtex_view_method = "zathura"

			vim.g.vimtex_syntax_conceal = {
					accents = 1,
					ligatures = 1,
					cites = 1,
					fancy = 1,
					spacing = 1,
					greek = 1,
					math_bounds = 1,
					math_delimiters = 0,
					math_fracs = 1,
					math_super_sub = 1,
					math_symbols = 1,
					sections = 0,
					styles = 1,
		 }

			require("nvim-treesitter.configs").setup({
				ensure_installed = { "markdown" },
				highlight = {
					enable = true,
					disable = { "latex" },
					additional_vim_regex_highlighting = { "latex", "markdown" },
				},
				--other treesitter settings
			})
		end,

		config = function()
			local map = require("langmapper").map

			map("n", "<localleader>ll", "<cmd>VimtexCompile<CR>")

		end,
	},
}
