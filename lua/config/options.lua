vim.schedule(function() -- Schedule the setting after `UiEnter` because it can increase startup-time.
	vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true -- Cursor line highlight
vim.opt.colorcolumn = '80'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.autochdir = true
vim.opt.undofile = false

vim.opt.incsearch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true -- Case sensitive when capital letters

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.scrolloff = 8
vim.opt.showmode = false -- Since mode is already in the statusline
vim.opt.breakindent = true
vim.opt.undofile = true -- Save undo history

vim.opt.updatetime = 150 -- Decrease update time
vim.opt.timeoutlen = 1000 -- Ex: leader key timeout

vim.opt.signcolumn = 'yes' -- For symbols on the left
vim.opt.mouse = 'a' -- Enable mouse mode

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- Sets how neovim will display certain whitespaces.

vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3 -- Tree listing
