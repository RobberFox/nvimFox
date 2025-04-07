local function snug_text()
	local line = vim.fn.getline(vim.fn.line("."))
	local cursor = vim.api.nvim_win_get_cursor(0)

	local braces = {
		{"%(", "%)"},
		{"%[", "%]"},
		{"%|", "%|"},
		{"\\{", "\\}"},
		{"\\langle", "\\rangle"},
		{"\\lvert", "\\rvert"},
		{"\\lVert", "\\rVert"},
		{"\\lceil", "\\rceil"},
		{"\\lfloor", "\\rfloor"},
	}

	local spots = {
		opening = {},
		closing = {},
	}

	local position = cursor[2]
	local depth = 0

	local unwanted_brace_depth = 0
	for i = position, #line, 1 do
		for _, brace in ipairs(braces) do
			local open = brace[1]
			local close = brace[2]
			local substr = line:sub(i+1-#close, i)

			if (substr == open) then
				unwanted_brace_depth = unwanted_brace_depth + 1
			end
			if (unwanted_brace_depth == 0) and (substr == close) then
				depth = depth + 1
				table.insert(spots.closing, i)
			elseif (substr == close) then
				unwanted_brace_depth = unwanted_brace_depth - 1
			end
		end
	end

	unwanted_brace_depth = 0
	for i = position, 1, -1 do
		for _, brace in ipairs(braces) do
			local open = brace[1]
			local close = brace[2]
			local substr = line:sub(i, i-1+#open)

			if (substr == close) then
				unwanted_brace_depth = unwanted_brace_depth + 1
			end

			if (unwanted_brace_depth == 0) and (substr == open) then
				depth = depth - 1
				table.insert(spots.opening, i)
			elseif (substr == open) then
				unwanted_brace_depth = unwanted_brace_depth - 1
			end
		end

		if depth == 0 then
			break
		end
	end

	function string.insert(str1, str2, pos)
		return str1:sub(1,pos)..str2..str1:sub(pos+1)
	end

	local right = "\\right"
	local left = "\\left"
	local shift = 0
	for _,i in ipairs(spots.closing) do
		line = string.insert(line, right, i-1+shift)
		shift = shift + #right
	end

	for _,i in ipairs(spots.opening) do
		line = string.insert(line, left, i-1)
	end

	vim.fn.setline(".", line)
	vim.api.nvim_win_set_cursor(0, { cursor[1], position+shift-2 })
end

return snug_text
