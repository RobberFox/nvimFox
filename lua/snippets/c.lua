local mysnips = {}

mysnips[#mysnips+1] = s({ trig="inc" }, { c(1, {
	fmt("#include <{}>", { r(1, "text") }),
	fmta("#include \"<>\"", { r(1, "text") })
})}, {
	stored = { ["text"] = i(1, "stdio.h") }
})

return mysnips
