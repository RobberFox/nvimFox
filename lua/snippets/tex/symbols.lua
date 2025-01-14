local math = require("snippets.helper_functions")

local symbols = {
	{"\"a", "\\alpha"},
	{"\"b", "\\beta"},
	{"\"c", "\\chi"},
	{"\"g", "\\gamma"},
	{"\"G", "\\Gamma"},
	{"\"d", "\\delta"},
	{"\"D", "\\Delta"},
	{"\"e", "\\epsilon"},
	{":e", "\\varepsilon"},
	{"\"z", "\\zeta"},
	{"\"t", "\\theta"},
	{":t", "\\vartheta"},
	{"\"T", "\\Theta"},
	{"\"i", "\\iota"},
	{"\"k", "\\kappa"},
	{"\"l", "\\lambda"},
	{"\"L", "\\Lambda"},
	{"\"r", "\\rho"},
	{":r", "\\varrho"},
	{"\"s", "\\sigma"},
	{"\"S", "\\Sigma"},
	{"\"u", "\\upsilon"},
	{"\"U", "\\Upsilon"},
	{"\"p", "\\phi"},
	{":p", "\\varphi"},
	{"\"P", "\\Phi"},
	{"\"o", "\\omega"},
	{"\"O", "\\Omega"},
	{"\"x", "\\xi"},
	{"\"X", "\\Xi"},

	{"eta", "\\eta"},
	{"mu", "\\mu"},
	{"nu", "\\nu"},
	{"pi", "\\pi"},
	{"Pi", "\\Pi"},
	{"tau", "\\tau"},
	{"phi", "\\phi"},
	{"Phi", "\\Phi"},
	{"chi", "\\chi"},
	{"psi", "\\psi"},
	{"Psi", "\\Psi"},

	-- Arrows
	{"<->", "\\leftrightarrow"},
	{"<>", "\\Leftrightarrow"},
	{"->", "\\to"},
	{"upar", "\\uparrow"},
	{"dar", "\\downarrow"},
	{"2ar", "\\nearrow"},
	{"4ar", "\\searrow"},
	{"8ar", "\\swarrow"},
	{"10ar", "\\nwarrow"},

	{"=>", "\\implies"},
	{"=<", "\\impliedby"},
	{"iff", "\\iff"},
	{"`=", "\\equiv"},
	{"!=", "\\neq"},
	{">=", "\\geq"},
	{"<=", "\\leq"},
	{"`>", "\\gg"},
	{"`<", "\\ll"},

	-- Random symbols
	{"3o", "\\infty"},
	{":o", "\\varnothing"},
	{"d6", "\\partial"},
	{"&*", "\\degree"},
	{"cdot&", "degree"},
	{"ang", "\\angle"},
	{"tt", "\\triangle"},
	{"Sq", "\\square"},
	{"%%", "\\% "},
	{"vv", "\\; \\vee \\;"},
	{"::", "\\;{\\tiny \\vdots}\\;"},
	{"`x", "\\times"},
	{"*", "\\cdot"},
	{"||", "\\parallel"},
	{"diag", "\\diagdown"},
	{"check", "\\checkmark"},

	{"+-", "\\pm"},
	{"-+", "\\mp"},

	{"~~", "\\sim"},
	{"~=", "\\approx"},
	{"prop", "\\propto"},
	{"nabl", "\\nabla"},

	{"..", "\\dots"},
	{".b", "\\ldots"},
	{".d", "\\ddots"},
	{".v", "\\vdots"},
	{".c", "\\cdots"},

	-- Logical operators
	{"land", "\\land"},
	{"lor", "\\lor"},
	{"neg", "\\lnot"},
	{"and", "\\cap"},
	{"#or", "\\cup"},

	-- Sets
	{"#in", "\\in"},
	{"!in", "\\notin"},
	{"sub", "\\subset"},
	{"\\subset=", "\\subseteq"},
	{"any", "\\forall"},
	{"#E", "\\exists"},
	{"!E", "\\nexists"},
	{"`\\", "\\setminus"},
	{"`|", "\\mid"},
}

local mysnips = {}

for index = 1, #symbols, 1 do
	mysnips[#mysnips+1] = s({ trig=symbols[index][1], wordTrig=false, snippetType="autosnippet" }, {
		t(symbols[index][2]),
	}, { condition = math })
end

return mysnips
