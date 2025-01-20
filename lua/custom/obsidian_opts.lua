return {
	workspaces = {
		{
			name = "personal",
			path = "~/stellardriven/",

			overrides = {
				disable_frontmatter = true
			}
		},
	},

	mappings = {
		["gf"] = {
			action = function()
				return require("obsidian").util.gf_passthrough()
			end,
			opts = { noremap = false, expr = true, buffer = true },
		},
		["<cr>"] = {
			action = function()
				return require("obsidian").util.smart_action()
			end,
			opts = { buffer = true, expr = true },
		}
	},

	new_notes_location = "current_dir",

	note_id_func = function(title)
		local suffix = ""
		if title ~= nil then
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		else
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
		end
		return tostring(os.time()) .. "-" .. suffix
	end,

	note_path_func = function(spec)
		local path = spec.dir / tostring(spec.title)
		return path:with_suffix(".md")
	end,

	wiki_link_func = "use_alias_only",

	preferred_link_style = "wiki",

	image_name_func = function()
		---@type obsidian.Client
		local client = require("obsidian").get_client()

		local note = client:current_note()
		if note then
			return string.format("%s/../Attachments/", note.path)
		else
			return string.format("%s-", os.time())
		end
	end,

	disable_frontmatter = true,

	note_frontmatter_func = function(note)
	end,

	templates = {
		folder = "0-Files/Templates",
	},

	daily_notes = {
		folder = "0-Files/Daily-Notes",
	},

	follow_url_func = function(url)
		vim.fn.jobstart({"xdg-open", url})
	end,

	attachments = {
		img_folder = "Attachments/",

		img_text_func = function(client, path)
			path = client:vault_relative_path(path) or path
			return string.format("![%s](%s)", path.name, path)
		end,
	},

	picker = {
		name = "fzf-lua",

		--mappings = {
		--	new = "<C-x>",
		--	insert_link = "<C-l>",
		--},
	},
}
