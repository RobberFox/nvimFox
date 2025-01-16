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

			ls.setup({
				enable_autosnippets = true,
				store_selection_keys="<Tab>"
			})

			map("n", "<leader>ls", function()
				require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/lua/snippets/"})
				vim.notify("Reloaded snippets.")
			end)

			map({"i", "s"}, "<A-y>", function()
				if ls.expandable() then
					ls.expand()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
				end
			end, {silent = true})
			map({"i", "s"}, "<Tab>", function()
				if ls.locally_jumpable(1) then
					ls.jump(1)
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

			require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/lua/snippets/"})
		end
	},
}
