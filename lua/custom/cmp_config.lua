local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = { completeopt = "menu,menuone,noinsert" },

	-- See `:help ins-completion`
	mapping = {
		["<Down>"] = cmp.mapping.select_next_item(),
		["<Up>"] = cmp.mapping.select_prev_item(),

		["<C-b>"] = cmp.mapping.scroll_docs(-8),
		["<C-f>"] = cmp.mapping.scroll_docs(8),

		["<C-y>"] = cmp.mapping.confirm { select = true },
		["<C-Space>"] = cmp.mapping.complete {},
		-- Advanced Luasnip keymaps: https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
	},
	sources = {
		{
			name = "lazydev",
			group_index = 0, -- To skip loading LuaLS completions (as lazydev recommends)
		},
		{ name = "nvim_lsp" },
		--{ name = "luasnip" },
		{ name = "path" },
	},
}

