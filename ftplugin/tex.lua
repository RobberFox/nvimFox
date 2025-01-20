local map = require("langmapper").map

vim.opt_local.spell = true

--vim.cmd([[au FileType tex setl spell]])
vim.opt_local.spelllang = "en_gb"

--map("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u")

local cmp = require('cmp')
local sources = cmp.get_config().sources

for i = #sources, 1, -1 do
	if sources[i].name == "luasnip" then
		table.remove(sources, i)
	end
end
cmp.setup.buffer({ sources = sources })

cmp.setup {
	completion = {
		autocomplete = false
	}
}
