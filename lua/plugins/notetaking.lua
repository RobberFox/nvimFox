return {
	{
		'Wansmer/langmapper.nvim',
		lazy = false,
		priority = 1, -- High priority is needed if you will use `autoremap()`

		config = function()
			require('langmapper').setup({
				---@type boolean Add mapping for every CTRL+ binding or not.
				map_all_ctrl = true,
				---@type string[] Modes to `map_all_ctrl`
				---Here and below each mode must be specified, even if some of them extend others.
				---E.g., 'v' includes 'x' and 's', but must be listed separate.
				ctrl_map_modes = { 'n', 'o', 'i', 'c', 't', 'v' },
				---@type boolean Wrap all keymap's functions (nvim_set_keymap etc)
				hack_keymap = true,
				---@type string[] Usually you don't want insert mode commands to be translated when hacking.
				---This does not affect normal wrapper functions, such as `langmapper.map`
				disable_hack_modes = { 'i' },
				---@type table Modes whose mappings will be checked during automapping.
				automapping_modes = { 'n', 'v', 'x', 's' },
				---@type string Standart English layout (on Mac, It may be different in your case.)
				default_layout = [[ABCDEFGHIJKLMNOPQRSTUVWXYZ<>:"{}~abcdefghijklmnopqrstuvwxyz,.;'[]`]],
				---@type string[] Names of layouts. If empty, will handle all configured layouts.
				use_layouts = {},
				---@type table Fallback layouts
				---Custom description builder:
				---  old_desc - original description,
				---  method - 'translate' (map translated lhs) or 'feedkeys' (call `nvim_feedkeys` with original lhs)
				---  lhs - original left-hand side for translation
				---should return new description as a string. If error is occurs or non-string is returned, original builder with `LM ()` prefix will use
				---@type nil|function(old_desc, method, lhs): string

				custom_desc = nil,
				layouts = {
					---@type table Fallback layout item. Name of key is a name of language
					ru = {
						---@type string Name of your second keyboard layout in system.
						---It should be the same as result string of `get_current_layout_id()`
						id = 'com.apple.keylayout.RussianWin',
						---@type string Fallback layout to translate. Should be same length as default layout
						layout = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯБЮЖЭХЪËфисвуапршолдьтщзйкыегмцчнябюжэхъё',
						---@type string if you need to specify default layout for this fallback layout
						default_layout = nil,
					},
				},
				os = {
					-- Darwin - Mac OS, the result of `vim.loop.os_uname().sysname`
					Darwin = {
						---Function for getting current keyboard layout on your OS
						---Should return string with id of layout
						---@return string
						get_current_layout_id = function()
							local cmd = 'im-select'
							if vim.fn.executable(cmd) then
								local output = vim.split(vim.trim(vim.fn.system(cmd)), '\n')
								return output[#output]
							end
						end,
					},
				},
			})
		end,
	},

	{
		"epwalsh/obsidian.nvim",
		version = "*",  -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
			'nvim-telescope/telescope.nvim',
			'nvim-treesitter/nvim-treesitter',
		},
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/stellardriven/",
				},
			},
		},
	},

	{
		"oflisback/obsidian-bridge.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},

		config = function() require("obsidian-bridge").setup() end,
		event = {
			"BufReadPre *.md",
			"BufNewFile *.md",
		},
		lazy = true,
	}
}
