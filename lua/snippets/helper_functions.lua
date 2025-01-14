local function math()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

return math
