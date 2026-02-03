return {
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",  -- recommended, use latest release instead of latest commit
		lazy = true,
		event = {
			"BufReadPre "..vim.fn.expand("~").."/stellardriven/**.md",
			"BufNewFile "..vim.fn.expand("~").."/stellardriven/**.md",
		},

		dependencies = {
			"saghen/blink.cmp",
		},

		config = function()
			require("custom.obsidian_config")

			local obsidian = require"obsidian"
			local function delete_to_trash()
				local note = obsidian.api.current_note()
				if not note or not note.path then
					return
				end
				local note_path = tostring(note.path) -- from path object to string
				local dest_path_obj = Obsidian.workspace.root / ".trash"

				if not dest_path_obj:is_dir() then
					dest_path_obj:mk_dir()
				end

				local out = vim.system({ "mv", note_path, tostring(dest_path_obj) }):wait() -- make this a sync operation

				if out.code ~= 0 then
					vim.notify("FAILED to delete to .trash")
				else
					vim.notify("File deleted to .trash")
				end
			end

			local map = require("langmapper").map

			map({"n", "i"}, "<C-S-d>", function()
				local current_buffer = vim.api.nvim_get_current_buf()
				delete_to_trash()
				vim.api.nvim_buf_delete(current_buffer, { force = true })
			end)
		end
	},
	{
		"oflisback/obsidian-bridge.nvim",
		lazy = true,
		event = {
			"BufReadPre "..vim.fn.expand("~").."/stellardriven/**.md",
			"BufNewFile "..vim.fn.expand("~").."/stellardriven/**.md",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},

		opts = {
			--	obsidian_server_address = "https://127.0.0.1:27124",
			--	cert_path = "~/.ssl/obsidian.crt",
		},
	}
}
