return {
	{
		'theprimeagen/harpoon',

		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>a", mark.add_file)
			vim.keymap.set({"n", "i"}, "<F3>", ui.toggle_quick_menu)

			vim.keymap.set({"n", "i"}, "<A-1>", function() ui.nav_file(1) end)
			vim.keymap.set({"n", "i"}, "<A-2>", function() ui.nav_file(2) end)
			vim.keymap.set({"n", "i"}, "<A-3>", function() ui.nav_file(3) end)
			vim.keymap.set({"n", "i"}, "<A-4>", function() ui.nav_file(4) end)


		end,
	},
	{
		'mbbill/undotree',

		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},
}
