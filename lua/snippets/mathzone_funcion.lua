local function in_mathzone()
	return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
end

function in_mathzone()
	if has_treesitter then
		local buf = vim.api.nvim_get_current_buf()
		local node = get_node_at_cursor()
		while node do
			if MATH_NODES[node:type()] then
				return true
			elseif node:type() == "math_environment" or node:type() == "generic_environment" then
				local begin = node:child(0)
				local names = begin and begin:field "name"
				if
					names
					and names[1]
					and MATH_ENVIRONMENTS[query.get_node_text(names[1], buf):match "[A-Za-z]+"]
					then
						return true
					end
				end
				node = node:parent()
			end
			return false
		end
	end
