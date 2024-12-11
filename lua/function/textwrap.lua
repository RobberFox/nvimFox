local map = require("langmapper").map

local function text_wrap(key, left, right, back)
	local step_back = right:len()
	if back ~= nil then
		step_back = back
	end

	map("n", key, function()
		local col = vim.fn.col('.') -- LMAO, literally the only difference
		local line = vim.api.nvim_get_current_line()

		if line:sub(col, col):match('%s') or (line == nil or line == '') then
			return "<Esc>a"..left..right..("h"):rep(step_back)
		elseif line:match("^>+") then
			local shift = line:match("^>+")
			return "<Esc>"..("<Left>"):rep(shift:len()).."mz^\"xdiw`z\"zciW"..left.."<Esc>\"zpa"..right.."<Esc>mz^\"xP`z"..("<Right>"):rep(shift:len()).."a"
		else
			return "<Esc>\"zciW"..left.."<Esc>\"zpa"..right
		end
	end, { expr = true })

	map("i", key, function()
		local col = vim.fn.col('.') - 1 -- LMAO, literally the only difference
		local line = vim.api.nvim_get_current_line()

		if line:sub(col, col):match('%s') or (line == nil or line == '') then
			return "<Esc>a"..left..right..("<Left>"):rep(step_back)
		elseif line:match("^>+") then
			local shift = line:match("^>+")
			return "<Esc>"..("<Left>"):rep(shift:len()).."mz^\"xdiw`z\"zciW"..left.."<Esc>\"zpa"..right.."<Esc>mz^\"xP`z"..("<Right>"):rep(shift:len()).."a"
		else
			return "<Esc>\"zciW"..left.."<Esc>\"zpa"..right
		end
	end, { expr = true })

	map("v", key,
	"\"zc"..left.."<Esc>\"zpa"..right..("<Left>"):rep(step_back) )
end

return text_wrap
