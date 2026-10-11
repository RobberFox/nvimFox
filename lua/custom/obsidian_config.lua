local obsidian = require("obsidian")

obsidian.setup {
	legacy_commands = false,

	notes_subdir = nil,
	new_notes_location = "current_dir",

	workspaces = {
		{
			name = "personal",
			path = "~/stellardriven/",
		},
	},

	note_id_func = function(title)
		return title
	end,

	link = {
		style = "wiki",
		wiki_link_style = "name_only",
		--style = function(opts)
		--	local header_or_block = ""
		--	if opts.anchor then
		--		header_or_block = string.format("#%s", opts.anchor.header)
		--	elseif opts.block then
		--		header_or_block = string.format("#%s", opts.block.id)
		--	end
		--	return string.format("[[%s%s]]", opts.label, header_or_block)
		--end,
	},

	templates = {
		folder = "0-Files/Templates",
	},

	daily_notes = {
		folder = "0-Files/Daily-Notes",
		date_format = "%Y-%m-%d",
	},

	completion = (function()
		return {
			min_chars = 2,
			match_case = false,
			create_new = true,
		}
	end)(),

	attachments = {
		folder = "./Attachments",
		img_name_func = function()
			return string.format("Pasted image %s", os.date "%Y%m%d%H%M%S")
		end,
		confirm_img_paste = false,
	},

	picker = {
		name = "fzf-lua",
	},

	search = {
		sort_by = "modified",
		sort_reversed = true,
		max_lines = 1000,
	},

	frontmatter = {
		enabled = false,
	},

	statusline = {
		enabled = false
	},

	footer = {
		enabled = false,
	},
}
