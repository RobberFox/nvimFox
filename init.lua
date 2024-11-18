-- require('config.helper_function')
-- local t = vim.opt.nrformats:get()
-- print(tprint(t))

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config")

require('langmapper').automapping({ global = true, buffer = true })
