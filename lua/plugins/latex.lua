return {
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
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

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",

		config = function()
			vim.keymap.set("n", "<leader>ls", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

			vim.keymap.set("i", "<Tab>", function() ls.expand() end, {silent = true})
			vim.keymap.set({"i", "s"}, "<Tab>", function() ls.jump( 1) end, {silent = true})
			vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})
			vim.keymap.set({"i", "s"}, "<C-l>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, {silent = true})
		end

	},
}
