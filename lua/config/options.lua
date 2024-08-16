vim.schedule(function() -- Schedule the setting after `UiEnter` because it can increase startup-time.
	vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true -- Show/highlight which line your cursor is on
vim.opt.colorcolumn = '80'

vim.opt.ignorecase = true
vim.opt.smartcase = true -- Case sensitive when capital letters

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 7 -- Scroll offset
vim.opt.showmode = false -- Since mode is already in the statusline
vim.opt.breakindent = true
vim.opt.undofile = true -- Save undo history

vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 1000 -- Ex: leader key timeout

vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.inccommand = 'split' -- Preview substitutions live, as you type
vim.opt.mouse = 'a' -- Enable mouse mode

-- See `:help 'list'` `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- Sets how neovim will display certain whitespaces.
