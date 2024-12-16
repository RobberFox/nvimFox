return {
	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		requires = { {"nvim-lua/plenary.nvim"} },

		config = function()
			local harpoon = require("harpoon")

			harpoon:setup({
				settings = {
					save_on_toggle = true,
					sync_on_ui_close = false,
					key = function()
						return vim.loop.cwd()
					end,
				},
			})

			local map = require('langmapper').map

			map("n", "<leader>a", function() harpoon:list():add() end)
			map({"n"}, "<leader>h", function() harpoon.ui:toggle_quick_menu((harpoon:list()), { border = "rounded", title_pos = "center" }) end)

			map({"n", "i"}, "<A-1>", function() harpoon:list():select(1) end)
			map({"n", "i"}, "<A-2>", function() harpoon:list():select(2) end)
			map({"n", "i"}, "<A-3>", function() harpoon:list():select(3) end)
			map({"n", "i"}, "<A-4>", function() harpoon:list():select(4) end)
			map({"n", "i"}, "<A-5>", function() harpoon:list():select(5) end)
			map({"n", "i"}, "<A-6>", function() harpoon:list():select(6) end)
			map({"n", "i"}, "<A-7>", function() harpoon:list():select(7) end)
			map({"n", "i"}, "<A-8>", function() harpoon:list():select(8) end)
			map({"n", "i"}, "<A-9>", function() harpoon:list():select(9) end)

		end,
	},

	{
		'tpope/vim-eunuch',
	},

	{
		"mbbill/undotree",

		config = function()
			local map = require('langmapper').map

			map("n", "<leader>u", vim.cmd.UndotreeToggle)
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
			local map = require('langmapper').map
			map({"n", "i"}, "<A-h>", "<cmd>Neotree toggle=true<CR>" )

			local toggle_autoclose = true
			map("n", "<leader>ta", function()
				toggle_autoclose = not toggle_autoclose
				vim.notify("Neotree autoclose: "..tostring(toggle_autoclose))
			end)

			require("neo-tree").setup({
				window = {
					mappings = {
						["Z"] = "expand_all_nodes",
						["/"] = "none",
					},
				},
				event_handlers = {
					{
						event = "neo_tree_buffer_enter",
						handler = function(arg)
							vim.cmd([[ setlocal relativenumber ]])
						end,
					},
					{
						event = "file_open_requested",
						handler = function()
							if toggle_autoclose == true then
								require("neo-tree.command").execute({ action = "close" })
							end
						end
					},
				},
			})
		end,
	}
}
