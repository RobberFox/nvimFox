vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "v$", "v$h")

-- 3 ways to refer to command-line commands: "<cmd>commandhere", ":commandhere" vim.cmd.commandhere"
-- vim.keymap.set("n", "<leader>ep", vim.cmd.Explore)

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

--vim.keymap.set({"n", "i"}, "<A-c>", "<cmd>%y<CR>")

-- vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Sigma yank-substitute remap
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch)
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<S-CR>", "<nop>")

-- See: `:help quickfix`
vim.keymap.set("n", "<leader>cn", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>b", "<cmd>!chmod u+x %<CR>")

-- vim.keymap.set("n", "<F2>", "<cmd>split term://bash<enter>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>") -- <Esc><Esc> won"t work on all terminal emulators
vim.keymap.set("n", "<F7>", "<cmd>!gcc % -lm && ./a.out <CR>")

--vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" }) -- Diagnostic keymap

-- See: `:help wincmd` - list of all window commands
vim.keymap.set({"n", "i"}, "<A-Left>", "<Esc><C-w><C-h>")
vim.keymap.set({"n", "i"}, "<A-Right>", "<Esc><C-w><C-l>")
vim.keymap.set({"n", "i"}, "<A-Down>", "<Esc><C-w><C-j>")
vim.keymap.set({"n", "i"}, "<A-Up>", "<Esc><C-w><C-k>")

-- Write, quit
vim.keymap.set({"n", "i"},"<C-s>", "<cmd>wall!<CR>")
vim.keymap.set({"n", "i"},"<C-q>", "<cmd>qall<CR>")

vim.keymap.set("n", "<leader>x", "<cmd>set foldmethod=marker<CR>")

-- NOTE: ### MEGA KEYBINDING ###
local tprint = require("function.tableprint") -- table printing function

vim.keymap.set("n", "<leader>z", function() -- Increment character alphabetically
	if (vim.opt.nrformats:get()[3] == "alpha") then
		vim.opt.nrformats:remove{"alpha"}
		vim.notify(tprint(vim.opt.nrformats:get()))
	else
		vim.opt.nrformats:append{"alpha"}
		vim.notify(tprint(vim.opt.nrformats:get()))
	end
end)
