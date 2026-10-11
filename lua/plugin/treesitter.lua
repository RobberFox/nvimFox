return {
	{
		"romus204/tree-sitter-manager.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" }, -- Optional extra text objects
			config = function()
			require("tree-sitter-manager").setup({
				-- Only specify the ones Neovim doesn't bundle natively
				ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc", "latex" },
				highlight = { enable = true }
				})
			end,
		}
	}
