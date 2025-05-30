-- `neo-tree` - disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- Vanilla nvim confiuration
require("main.options")
require("main.autocommand")
-- `custom/` is for plugins that I configure in a separate file, then refer to them in the plugin spec

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugin" },
	},
	-- Configure any other settings here. See the documentation for more details.
	install = { colorscheme = { "tokyonight-night" } },
	checker = { enabled = false }, -- automatically check for plugin updates
})

vim.keymap.set({"n", "i"}, "<F10>", function() pcall(ts.get_parser, buf, "latex") end)

require("main.remap") -- in the end, because I need `langmapper` to load
