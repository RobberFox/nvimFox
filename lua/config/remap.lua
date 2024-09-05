vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--  See `:help vim.keymap.set()`
-- 3 ways to refer to command-line commands: '<cmd>commandhere', ':commandhere' vim.cmd.commandhere'
vim.keymap.set("n", "<leader>ep", vim.cmd.Explore)
vim.keymap.set("n", "<leader>nt", "<cmd>Neotree toggle=true<CR>" )

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set({"n", "i"}, "<A-c>", "<cmd>%y<CR>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- sigma yank-substitute remap
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "Q", "<nop>")

-- See: `:help quickfix`
vim.keymap.set("n", "<leader>cn", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch)

vim.keymap.set('n', '<F2>', '<cmd>split term://bash<enter>', { desc = 'Open terminal' }) -- Terminal emulator keymap
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' }) -- <Esc><Esc> won't work on all terminal emulators
vim.keymap.set('n', '<F7>', '<cmd>!gcc % && ./a.out <CR>', { desc = 'compile C code with the gcc compiler' }) -- Compiling keymap

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' }) -- Diagnostic keymap

-- See: `:help wincmd` - list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
