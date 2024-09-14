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

vim.api.nvim_create_autocmd("BufEnter", {
	desc = 'Prevent style overrides from /usr/share/nvim/runtime/...',
	group = vim.api.nvim_create_augroup('robberfox-tab', { clear = true }),
	callback = function()
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4
		vim.opt.softtabstop = 4
		vim.opt.expandtab = false
	end
})
