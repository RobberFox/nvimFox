return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc", "latex" },
			auto_install = true,
			highlight = {
				enable = true,

				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			require("vim.treesitter.query").set( "markdown", -- Don't conceal code blocks
			'highlights',
			[[
			;From MDeiml/tree-sitter-markdown
			[
			(fenced_code_block_delimiter)
			] @punctuation.delimiter
			]])
		end,
	},
}
