return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",

		opts = {
			enable_autosnippets = true,
		},

		config = function()
			local ls = require("luasnip")
			local map = require('langmapper').map

			ls.config.setup({ enable_autosnippets = true })

			map("n", "<leader>ls", "<cmd>source ~/.config/nvim/lua/snippets/all.lua<CR>")

			map({"i", "s"}, "<Tab>", function()
				if ls.expand_or_locally_jumpable() then
					ls.expand_or_jump()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
				end
			end, {silent = true})
			map({"i", "s"}, "<S-Tab>", function()
				if ls.locally_jumpable(-1) then
					ls.jump(-1)
				end
			end, {silent = true})
			map({"i", "s"}, "<C-l>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, {silent = true})

			require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/snippets/"})
		end
	},
}
