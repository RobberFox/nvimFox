vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--  See `:help vim.keymap.set()`
-- 3 ways to refer to command-line commands: '<cmd>commandhere', ':commandhere' vim.cmd.commandhere'
vim.keymap.set("n", "<leader>ep", vim.cmd.Ex)

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
