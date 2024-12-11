local ls = require("luasnip")

ls.config.setup({ enable_autosnippets = true })

vim.keymap.set("n", "<leader>ls", "<cmd>source ~/.config/nvim/lua/snippets/all.lua<CR>")

vim.keymap.set({"i", "s"}, "<Tab>", function()
	if ls.expand_or_locally_jumpable() then
		ls.expand_or_jump()
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
	end
end, {silent = true})
vim.keymap.set({"i", "s"}, "<S-Tab>", function()
	if ls.locally_jumpable(-1) then
		ls.jump(-1)
	end
end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/snippets/"})
