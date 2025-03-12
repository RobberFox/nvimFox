-- 1. Invoke the hotkey
-- 2. Prompt the new filename
-- 3. Check if an image with such filename exists. Throw an error if not.
-- 4. Inside a new kitty window, run my `paste.sh` script with the filename.
-- 5. Copy the wikilink formatted filename to the clipboard

-- NOTE: maybe I can create a new buffer in a separate tab so that it's more seamless while taking notes.

local script_dir = vim.fn.expand("~").."/code/d2/"
local paste_dir = vim.fn.expand("~").."/stellardriven/3-Dev/Attachments/"

local function kitty_execute(cmd)
	return "!"..script_dir.."kitty.sh \""..cmd.."\\x0d\""
end

vim.keymap.set("n", "<F4>", function()
	local file = vim.fn.expand("%:t"):match("[^.]+")
	local filename = vim.fn.input { prompt = "Enter figure name: ", default = file }

	if filename == "" then
		vim.notify("Aborted!")
		return
	end

	local file_d2 = script_dir..filename..".d2"
	local file_svg = paste_dir..filename..".svg"

	vim.cmd("!echo -n ".."\\![["..filename..".svg]]".." | xclip -selection c")

	if vim.fn.filereadable(file_svg) == 0 then
		vim.cmd(kitty_execute(script_dir.."watch.sh "..file_d2.." "..file_svg))
	else
		vim.notify("Filename exists! Overriding.")
		vim.cmd(kitty_execute(script_dir.."watch.sh "..file_d2.." "..file_svg))
	end
end)
