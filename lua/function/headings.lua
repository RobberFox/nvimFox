function heading(num)
	local preceding_line = vim.fn.getline(vim.fn.line(".") - 1)
	local carets = preceding_line:match("^>*")

	if preceding_line:match("^>*%d%.%s.") then
		local list_index = preceding_line:match("%d")
		vim.fn.setline(".", carets..tostring(list_index+1)..". ")

	elseif preceding_line:match("^>*%d%.%s$") or preceding_line:match("^>*%d%.$") then
		vim.fn.setline(vim.fn.line(".")-1, carets)
	end
end

return heading
