return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim", -- library

			{ -- When you face errors: go to telescope-fzf-native README
				"nvim-telescope/telescope-fzf-native.nvim",

				build = "make", -- `build` is used to some commands only when the plugin is installed/updated.

				cond = function() -- condition to determine if plugin should be installed and loaded
					return vim.fn.executable "make" == 1
				end,
			},

			"nvim-telescope/telescope-ui-select.nvim",

			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }, -- For pretty icons, requires Nerd Font
		},

		config = function()
			--  <c-/> (insert) or ? (normal) -- show keymaps for the current Telescope picker

			require("telescope").setup {
				extensions = {
					["ui-select"] = { require("telescope.themes").get_dropdown() },
				},
			}

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags)
			vim.keymap.set("n", "<leader>sk", builtin.keymaps)
			vim.keymap.set("n", "<leader>sf", builtin.find_files)
			vim.keymap.set("n", "<leader>ss", builtin.builtin)
			vim.keymap.set("n", "<leader>sw", builtin.grep_string)
			vim.keymap.set("n", "<leader>sg", builtin.live_grep)
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics)
			vim.keymap.set("n", "<leader>sr", builtin.resume)
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles)
			vim.keymap.set("n", "<leader><leader>", builtin.buffers)

			-- Passing function to change Telescope"s appearance
			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
					winblend = 0, -- transparency
					previewer = false,
				})
			end)

			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep {
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				}
			end)

			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files {
					cwd = vim.fn.stdpath "config" -- cwd is overriden with config folder
				}
			end)
		end,
	},
}
