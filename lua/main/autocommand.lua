-- See `:help lua-guide-autocommands`

-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank { timeout = 60 }
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Do :set formatoptions-=cro", -- since runtime files would override it otherwise
	group = vim.api.nvim_create_augroup("robberfox-commentformat", { clear = true }),
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove{ "c", "r", "o" }
	end
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Prevent style overrides from /usr/share/nvim/runtime/...",
	pattern = "*lua",
	group = vim.api.nvim_create_augroup("robberfox-tab", { clear = true }),
	callback = function()
		vim.opt.tabstop = 3
		vim.opt.shiftwidth = 3
		vim.opt.softtabstop = 3
		vim.opt.expandtab = false
	end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function()
		if require("nvim-treesitter.parsers").has_parser() then
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		else
			vim.opt.foldmethod = "syntax"
		end
	end,
})
