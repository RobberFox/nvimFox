return {
	{
		'terrastruct/d2-vim',
		ft = "d2",
	},
	-- config = function()
	-- 	vim.g.d2_block_string_syntaxes = {
	-- 		d2 = 'd2',
	-- 		markdown = { 'md', 'markdown' },
	-- 		javascript = { 'javascript', 'js' },
	-- 		html = 'html',
	-- 		json = 'json',
	-- 		c = 'c',
	-- 		go = 'go',
	-- 		sh = { 'sh', 'ksh', 'bash' },
	-- 		css = 'css',
	-- 		vim = 'vim',
	-- 		}
	-- end
	--{
	--	"nvim-neo-tree/neo-tree.nvim",
	--	branch = "v3.x",
	--	dependencies = {
	--		"nvim-lua/plenary.nvim",
	--		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	--		"MunifTanjim/nui.nvim",
	--		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	--	}
	--}
	{
		'Aasim-A/scrollEOF.nvim',
		opts = {},
	}

}
