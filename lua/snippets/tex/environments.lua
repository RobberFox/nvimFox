local math = require("snippets.helper_functions")

local mysnips = {
	ms({ common = { snippetType = "autosnippet" }, "mk", "ьл" }, fmta([[$<>$<>]], { i(1), i(2) })),
	ms({ common = { snippetType = "autosnippet" }, "dm", "вь" }, fmta([[
	\begin{equation}
		<>
	\end{equation}
	]], { i(1) })),

	s({ trig = "beg", snippetType = "autosnippet" }, fmta([[
	\begin{<>}
		<>
	\end{<>}
	]], { i(1), i(2), rep(1) })),

	s({ trig = "aram", snippetType = "autosnippet" }, fmta([[
	\left( \begin{array}{<>}
		<>
	\end{array} \right)
	]], { i(1), i(2) }), { condition = math }),
}

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
	mysnips[#mysnips+1] = s({ trig=matrices[index][1], snippetType="autosnippet" }, fmta([[
	\begin{]]..matrices[index][2]..[[}
		<>
	\end{]]..matrices[index][2]..[[}]], { i(1) }), { condition = math })
end

return mysnips
