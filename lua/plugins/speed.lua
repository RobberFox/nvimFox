return {
	{
		'theprimeagen/harpoon',
		branch = 'harpoon2',
		requires = { {"nvim-lua/plenary.nvim"} },

		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()

			vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
			vim.keymap.set({"n"}, "<leader>h", function() harpoon.ui:toggle_quick_menu((harpoon:list()), { border = "rounded", title_pos = "center" }) end)

			vim.keymap.set({"n", "i"}, "<A-1>", function() harpoon:list():select(1) end)
			vim.keymap.set({"n", "i"}, "<A-2>", function() harpoon:list():select(2) end)
			vim.keymap.set({"n", "i"}, "<A-3>", function() harpoon:list():select(3) end)
			vim.keymap.set({"n", "i"}, "<A-4>", function() harpoon:list():select(4) end)

		end,
	},

	{
		'mbbill/undotree',

		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		},


		config = function()
			vim.keymap.set("n", "<leader>ep", "<cmd>Neotree toggle=true<CR>" )

			require("neo-tree").setup({
				window = {
					width = 25,
					mappings = {
						["Z"] = "expand_all_nodes",
					},
				},
				event_handlers = {
					{
						event = "neo_tree_buffer_enter",
						handler = function(arg)
							vim.cmd([[ setlocal relativenumber ]])
						end,
					},
				},
			})
		end,
	}
}
