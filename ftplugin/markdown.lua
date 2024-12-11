vim.opt.linebreak = true
vim.cmd([[au FileType markdown setl comments=b:*,b:-,b:+,n:>]])
vim.cmd([[au FileType markdown setl formatoptions+=r]])

local map = require("langmapper").map

map("n", "q", "<nop>")
map("n", "<leader>q", "q", { noremap = true })


map({"n", "i"}, "<A-g>", "<Esc>i```<Enter>```<Enter><Esc>2kA")
map("v", "<A-g>", "c```<Enter>```<Esc>kpkA")

require("function.markdown_list") -- Its function is not needed, at least yet
map("i", "<CR>", "<CR><Esc><cmd>MarkdownAutoList<CR>A", { buffer = true, noremap = true })

local text_wrap = require("function.textwrap")
text_wrap("<A-q>", "**", "**")
text_wrap("<A-w>", "*(", ")*")
text_wrap("<A-e>", "==", "==")
text_wrap("<A-r>", "~~", "~~")
text_wrap("<A-a>", "![[", "]]")
text_wrap("<A-s>", "[[", "]]")
text_wrap("<A-d>", "`", "`")
text_wrap("<A-f>", "[]", "()", 3)
text_wrap("<A-b>", "%%", "%%")

local checkbox_function = require("function.checkbox")
map({"n", "i"}, "<A-t>", function() checkbox_function() end)

local heading_function = require("function.headings")
for i = 1, 5, 1 do
	map({"n", "i"}, "<C-"..i..">", function() heading_function(i) end)
end

map({"n", "i"}, "<F2>", "<cmd>ObsidianRename<CR>")
map({"n", "i"}, "<A-c>", "<cmd>ObsidianTemplate<CR>")
map({"n", "i"}, "<A-v>", "<cmd>ObsidianPasteImg<CR>")
map({"n", "i"}, "<A-o>", "<cmd>ObsidianQuickSwitch<CR>")
map({"n", "i"}, "<A-l>", "<cmd>ObsidianBacklinks<CR>")
map({"n", "i"}, "<A-m>", "<cmd>ObsidianExtractNote<CR>")
map({"n", "i"}, "<A-j>", "<cmd>ObsidianSearch<CR>")
map({"n", "i"}, "<A-n>", "<cmd>ObsidianNew<CR>")