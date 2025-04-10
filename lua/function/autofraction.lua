local breaking_chars = "%$%+%-=;:<>"

function get_opening_bracket(char)
	local set = {
		[")"] = "(",
		["]"] = "[",
		["}"] = "{",
	}

	return set[char]
end

function get_matching_bracket(str, start, open_bracket, close_bracket)
	local depth = 0
	for i = start, 1, -1 do
		char = str:sub(i, i)

		if char == close_bracket then
			depth = depth + 1
		elseif char == open_bracket then
			depth = depth - 1
		end

		if depth == 0 then
			return i
		end
	end

	return -1
end

function equation_bounds(str)
	for i = str:len(), 1, -1 do
		local cur_char = str:sub(i, i)
		if cur_char == "$" then
			return i
		end
	end

	return -1
end

function auto_fraction(str)
	local stripped = str:len() -- since don't need the trailing `/`
	local to = stripped
	local equation_start = equation_bounds(str)

	local start = equation_start

	local i = stripped
	while i >= equation_start do
		local cur_char = str:sub(i, i)

		if (")]}"):find(cur_char, 1, true) and cur_char ~= "" then
			local close_bracket = cur_char
			local open_bracket = get_opening_bracket(close_bracket) -- i.e just the symbol

			local j = get_matching_bracket(str, i, open_bracket, close_bracket)

			if j == -1 then
				return false
			end

			i = j

			if i < equation_start then
				start = equation_start
				break
			end
		end

		if (" $([{\n"..breaking_chars):find(cur_char, 1, true) and cur_char ~= "" then
			start = i + 1
			break
		end

		i = i - 1
	end

	local numerator = str:sub(start, to)

	if numerator:sub(1, 1) == "(" and numerator:sub(-1, -1) == ")" then
		numerator = numerator:sub(2, -2)
		start = start + 1
		to = to - 1
	end

	return start, to
end

return auto_fraction
