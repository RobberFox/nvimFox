vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 3 ways to refer to command-line commands: '<cmd>commandhere', ':commandhere' vim.cmd.commandhere'
-- vim.keymap.set("n", "<leader>ep", vim.cmd.Explore)

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set({"n", "i"}, "<A-c>", "<cmd>%y<CR>")

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

vim.keymap.set("n", "<F2>", "<cmd>split term://bash<enter>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>") -- <Esc><Esc> won"t work on all terminal emulators
vim.keymap.set("n", "<F7>", "<cmd>!gcc % && ./a.out <CR>")

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" }) -- Diagnostic keymap

-- See: `:help wincmd` - list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

-- Write, quit
vim.keymap.set({"n", "i"},"<A-s>", "<cmd>wall<CR>")
vim.keymap.set({"n", "i"},"<A-q>", "<cmd>qall<CR>")

-- NOTE: ### MEGA KEYBINDING ###
require("config.helper_function") -- table printing function

vim.keymap.set("n", "<leader>z", function()
	if (vim.opt.nrformats:get()[3] == "alpha") then
		vim.opt.nrformats:remove{"alpha"}
		vim.notify(tprint(vim.opt.nrformats:get()))
	else
		vim.opt.nrformats:append{"alpha"}
		vim.notify(tprint(vim.opt.nrformats:get()))
	end
end) -- Increment character alphabetically

-- big ligma
