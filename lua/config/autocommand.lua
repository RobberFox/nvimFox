-- See `:help lua-guide-autocommands`

-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank { timeout = 60 }
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = 'Do :set formatoptions-=cro', -- since runtime files would override it otherwise
	group = vim.api.nvim_create_augroup('robberfox-commentformat', { clear = true }),
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove{ 'c', 'r', 'o' }
	end
})

