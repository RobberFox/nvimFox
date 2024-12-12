function heading(num)
	local line = vim.fn.getline(vim.fn.line("."))
	local cursor = vim.api.nvim_win_get_cursor(0)
	local carets = line:match("^>*")

	if line:match("^>*%s*#+") then
		local heading = line:match("#+%s*")
		local text = line:gsub(carets..heading, "")

		vim.fn.setline(".", carets..("#"):rep(num).." "..text)

	else
		local text = line:gsub(carets, "")
		vim.fn.setline(".", carets..("#"):rep(num).." "..text)
	end

	vim.api.nvim_win_set_cursor(0, { cursor[1], vim.v.maxcol })
end

return heading
