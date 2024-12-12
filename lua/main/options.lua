vim.schedule(function() -- Schedule the setting after `UiEnter` because it can increase startup-time.
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true -- Cursor line highlight
vim.opt.colorcolumn = "80"

vim.opt.conceallevel = 1
vim.opt.foldenable = false

-- Not working for lua: use autocommands
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- vim.opt.autochdir = true
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

vim.opt.signcolumn = "yes" -- For symbols on the left
vim.opt.mouse = "a" -- Enable mouse mode

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Sets how neovim will display certain whitespaces.

-- vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"
-- vim.g.netrw_banner = 0
-- vim.g.netrw_liststyle = 3 -- Tree listing

vim.g.tex_flavor = "latex"

-- NOTE: Language stuff

local function escape(str)
  -- You need to escape these characters to work correctly
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

-- Recommended to use lua template string
local en = [[`qwertyuiop[]asdfghjkl;"zxcvbnm,.]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмитьбю]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

vim.opt.langmap = vim.fn.join({
	-- | `to` should be first     | `from` should be second
	escape(ru_shift) .. ";" .. escape(en_shift),
	escape(ru) .. ";" .. escape(en),
}, ",")

vim.opt.langmap:append(vim.fn.join({"ёЁ;`~"}, ","))
