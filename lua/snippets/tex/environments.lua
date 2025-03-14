local math = require("function.mathzone")

local mysnips = {}

mysnips[#mysnips+1] = s({ trig = "mk", regTrig=true, snippetType = "autosnippet" }, fmta([[$<>$<>]], { i(1), i(2) }))
mysnips[#mysnips+1] = s({ trig = "([%s%.,;:\"])ьл", regTrig=true, snippetType = "autosnippet" }, fmta([[<>$<>$<>]],
{ f(function(args, snip) return snip.captures[1] end, {}), i(1), i(2) }))
mysnips[#mysnips+1] = ms({ common = { regTrig=true, snippetType = "autosnippet" }, "^dm", "^вь" }, fmta([[
\begin{equation}
<>
\end{equation}
]], { i(1) }))

mysnips[#mysnips+1] = s({ trig = "beg", wordTrig=false, snippetType = "autosnippet" }, fmta([[
\begin{<>}
<>
\end{<>}
]], { i(1), i(2), rep(1) }))

mysnips[#mysnips+1] = s({ trig = "aram", wordTrig=false, snippetType = "autosnippet" }, fmta([[
\left( \begin{array}{<>}
<>
\end{array} \right)
]], { i(1), i(2) }), { condition = math })

local matrices = {
	{"pmat", "pmatrix"},
	{"bmat", "bmatrix"},
	{"Bmat", "Bmatrix"},
	{"vmat", "vmatrix"},
	{"Vmat", "Vmatrix"},

	{"gath", "gathered"},
	{"case", "cases"},
	{"rcase", "rcases"},
	{"align", "align"},
	{"array", "array"},
	{"matrix", "matrix"},
}

for index = 1, #matrices, 1 do
	mysnips[#mysnips+1] = s({ trig=matrices[index][1], snippetType="autosnippet", wordTrig=false }, fmta([[
	\begin{]]..matrices[index][2]..[[}
	<>
	\end{]]..matrices[index][2]..[[}]], { i(1) }), { condition = math })
end

return mysnips
