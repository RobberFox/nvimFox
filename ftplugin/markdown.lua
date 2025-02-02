vim.cmd([[au FileType markdown setl comments=b:*,b:-,b:+,n:>]])
vim.cmd([[au FileType markdown setl formatoptions+=r]])

local map = require("langmapper").map

map("n", "q", "<nop>")
map("n", "<leader>q", "q", { noremap = true })

map("n", "<leader>tc", function()
	local cursor = vim.api.nvim_win_get_cursor(0)
	vim.fn.search("^>[", "b")

	local line = vim.fn.getline(vim.fn.line("."))
	local callout = line:match("^>%[%!%S*]")
	local result = line:match("^>%[%!%S*]%-")

	if (result == nil) then
		line = line:gsub("^>%[%!%S*]", callout.."-")
	else
		line = line:gsub("^>%[%!%S*]%-", callout)
	end

	vim.fn.setline(".", line)
	vim.api.nvim_win_set_cursor(0, cursor)
end)

map({"n", "i"}, "<A-g>", "<Esc>i```<Enter>```<Enter><Esc>2kA")
map("v", "<A-g>", "c```<Enter>```<Esc>kpkA")

require("function.markdown_list") -- Its function is not needed, at least yet
map("i", "<CR>", "<CR><Esc><cmd>MarkdownAutoList<CR>A", { buffer = true, noremap = true })

local wrap = require("function.textwrap")
wrap.full("<A-q>", "**", "**")
wrap.full("<A-w>", "*(", ")*")
wrap.full("<A-e>", "==", "==")
wrap.full("<A-r>", "~~", "~~")

wrap.simple("<A-a>", "![[", "]]")
wrap.simple("<A-s>", "[[", "]]")
wrap.full("<A-d>", "`", "`")
wrap.simple("<A-f>", "[](", ")", 3)
wrap.full("<A-b>", "%%", "%%")

local checkbox_function = require("function.checkbox")
map({"n", "i"}, "<A-t>", function() checkbox_function() end)

local heading_function = require("function.headings")
for i = 1, 5, 1 do
	map({"n", "i"}, "<C-"..i..">", function() heading_function(i) end)
end

map({"n", "i"}, "<C-k>", "<cmd>ObsidianFollowLink<CR>")
map({"n", "i"}, "<F2>", "<cmd>ObsidianRename<CR>")
map({"n", "i"}, "<A-c>", "<cmd>ObsidianTemplate<CR>")
map({"n", "i"}, "<A-v>", "<cmd>ObsidianPasteImg<CR>")
map({"n", "i"}, "<A-o>", "<cmd>ObsidianQuickSwitch<CR>")
map({"n", "i"}, "<A-l>", "<cmd>ObsidianBacklinks<CR>")
map({"n", "i"}, "<A-m>", "<cmd>ObsidianExtractNote<CR>")
map({"n", "i"}, "<A-j>", "<cmd>ObsidianSearch<CR>")
map({"n", "i"}, "<A-n>", "<cmd>ObsidianNew<CR>")
map({"n", "i"}, "<A-k>", "<cmd>ObsidianTOC<CR>")

vim.opt.linebreak = true

--vim.api.nvim_set_hl(0, "Normal", { fg = "#ffffff", bg = "#333333" })
--vim.api.nvim_set_hl(0, "Comment", { fg = "#111111", bold = true })
--vim.api.nvim_set_hl(0, "Error", { fg = "#ffffff", undercurl = true })
--vim.api.nvim_set_hl(0, "Cursor", { reverse = true })

--black "#222436"
--red "#ff757f"
--green "#c3e88d"
--yellow "#ffc777"
--blue "#82aaff"
--magenta "#c099ff"
--cyan "#86e1fc"
--white "#828bb8"
--orange "#ff966c"

for i = 1, 6, 1 do
	vim.api.nvim_set_hl(0, "markdownH"..tostring(i), { fg = "#ff757f", bg = "#452e2e", bold = true })
	vim.api.nvim_set_hl(0, "markdownH"..tostring(i).."Delimiter", { fg = "#ff757f", bg = "#452e2e" })
end

vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { fg = "#ff757f" })
vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { fg = "#c3e88d" })
vim.api.nvim_set_hl(0, "@markup.strikethrough.markdown_inline", { fg = "#82aaff" })

--vim.api.nvim_buf_add_highlight(0, 0, "markdownH3", 2, 0, -1)

require("fzf-lua").setup {
	files = {
		formatter = "path.filename_first"
	},
}

local cmp = require('cmp')
local sources = cmp.get_config().sources
for i = #sources, 1, -1 do
	if sources[i].name == "luasnip" then
		table.remove(sources, i)
	end
end
cmp.setup.buffer({ sources = sources })
