-- See `:help lua-guide-autocommands`

-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	allback = function()
		vim.hl.hl_op { timeout = 60 }
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Do :set formatoptions-=cro", -- since runtime files would override it otherwise
	group = vim.api.nvim_create_augroup("robberfox-commentformat", { clear = true }),
	pattern = { "*.lua", "*.c" },
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

--vim.api.nvim_create_autocmd({ "FileType" }, {
--	callback = function()
--		if require("nvim-treesitter.parsers").has_parser() then
--			vim.opt.foldmethod = "expr"
--			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--		else
--			vim.opt.foldmethod = "syntax"
--		end
--	end,
--})

vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function()
		if vim.treesitter.get_parser() then
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		else
			vim.opt.foldmethod = "syntax"
		end
	end,
})



vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = "*",
	callback = function(ev)
		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
		if ok and stats and stats.size > max_filesize then
			-- Deactivate treesitter highlighting for this buffer
			vim.treesitter.stop(ev.buf)
		end
	end,
})

--vim.api.nvim_create_autocmd("FileType", {
--	pattern = "markdown",
--	callback = function()
--		require("vim.treesitter.query").set( "markdown", -- Don't conceal code blocks
--		'highlights',
--		[[
--		;From MDeiml/tree-sitter-markdown
--		[
--		(fenced_code_block_delimiter)
--		] @punctuation.delimiter
--		]])
--	end,
--})
