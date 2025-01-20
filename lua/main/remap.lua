local map = require("langmapper").map
-- 3 ways to refer to command-line commands: "<cmd>commandhere", ":commandhere" vim.cmd.commandhere"
-- map("n", "<leader>ep", vim.cmd.Explore)

map("n", "v$", "vg_")

map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

--map({"n", "i"}, "<A-c>", "<cmd>%y<CR>")

-- map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Sigma yank-substitute remap
map("x", "<leader>p", "\"_dP")

map("n", "<Esc>", vim.cmd.nohlsearch)
--map("n", "Q", "<nop>")
map("n", "<S-CR>", "<nop>")

-- See: `:help quickfix`
map("n", "<leader>cn", "<cmd>cnext<CR>zz")
map("n", "<leader>cp", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lprev<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<leader>b", "<cmd>!chmod u+x %<CR>")

-- map("n", "<F2>", "<cmd>split term://bash<enter>")
map("t", "<Esc>", "<C-\\><C-n>") -- <Esc><Esc> won"t work on all terminal emulators
map({"n", "i"}, "<F7>", "<cmd>!gcc % -lm && ./a.out <CR>")

--map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" }) -- Diagnostic keymap

-- See: `:help wincmd` - list of all window commands
map({"n", "i"}, "<A-Left>", "<Esc><C-w><C-h>")
map({"n", "i"}, "<A-Right>", "<Esc><C-w><C-l>")
map({"n", "i"}, "<A-Down>", "<Esc><C-w><C-j>")
map({"n", "i"}, "<A-Up>", "<Esc><C-w><C-k>")

-- Write, quit
map({"n", "i"},"<C-s>", "<cmd>wall!<CR>")
map({"n", "i"},"<C-q>", "<cmd>qall<CR>")

map("n", "<leader>x", "<cmd>set foldmethod=marker<CR>")

-- NOTE: ### MEGA KEYBINDING ###
local tprint = require("function.tableprint") -- table printing function

map("n", "<leader>z", function() -- Increment character alphabetically
	if (vim.opt.nrformats:get()[3] == "alpha") then
		vim.opt.nrformats:remove{"alpha"}
		vim.notify(tprint(vim.opt.nrformats:get()))
	else
		vim.opt.nrformats:append{"alpha"}
		vim.notify(tprint(vim.opt.nrformats:get()))
	end
end)
