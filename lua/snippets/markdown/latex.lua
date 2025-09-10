local has_treesitter, ts = pcall(require, "vim.treesitter")
local _, query = pcall(require, "vim.treesitter.query")

local MATH_ENVIRONMENTS = {
	displaymath = true,
	eqnarray = true,
	equation = true,
	math = true,
	array = true,
}
local MATH_NODES = {
	displayed_equation = true,
	inline_formula = true,
}

local function get_node_at_cursor()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local cursor_range = { cursor[1] - 1, cursor[2] }
	local buf = vim.api.nvim_get_current_buf()
	local ok, parser = pcall(ts.get_parser, buf, "latex")
	if not ok or not parser then return end
	local root_tree = parser:parse()[1]
	local root = root_tree and root_tree:root()

	if not root then return end

	return root:named_descendant_for_range(cursor_range[1], cursor_range[2], cursor_range[1], cursor_range[2])
end

function math()
	if has_treesitter then
		local buf = vim.api.nvim_get_current_buf()
		local node = get_node_at_cursor()
		while node do
			if MATH_NODES[node:type()] then
				return true
			end
			if node:type() == "environment" then
				local begin = node:child(0)
				local names = begin and begin:field("name")

				if names and names[1] and MATH_ENVIRONMENTS[query.get_node_text(names[1], buf):gsub("[%s*]", "")] then
					return true
				end
			end
			node = node:parent()
		end
		return false
	end
end

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

	-- Operations and functions
	{"arg", "\\arg"},
	{"det", "\\det"},
	{"ell", "\\ell"},
}

local mysnips = {}

for index = 1, #symbols, 1 do
	mysnips[#mysnips+1] = s({ trig=symbols[index][1], wordTrig=false, snippetType="autosnippet" }, {
		t(symbols[index][2]),
	}, { condition = math })
end

-- More complex
mysnips[#mysnips+1] = s({ trig="set", wordTrig=false, snippetType="autosnippet" }, fmta([[\{<>\}]],
{ i(1) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="trace", wordTrig=false, snippetType="autosnippet" }, fmta([[\mathrm{Tr}(<>)]],
{ i(1) }), { condition = math })

-- Integrals
for index = 1, 3, 1 do
	mysnips[#mysnips+1] = s({ trig=("i"):rep(index).."nt", wordTrig=false, snippetType="autosnippet", priority = 100 }, fmta("\\"..("i"):rep(index).."nt_{<>}^{<>} <> \\, \\mathrm{d}<> <>",
	{ i(1, "0"), i(2, "\\infty"), i(3), i(4, "x"), i(0) }), { condition = math })
end

mysnips[#mysnips+1] = s( { trig="lint", wordTrig=false, snippetType="autosnippet" }, fmta([[\int_{<>} <> \, \mathrm{d}<>]],
{ i(1, "0"), i(2), i(3, "x") }), { condition = math })
mysnips[#mysnips+1] = s( { trig="oint", wordTrig=false, snippetType="autosnippet" }, fmta([[\oint_{<>}^{<>} <> \, \mathrm{d}<>]],
{ i(1, "0"), i(2, "\\infty"), i(3), i(4, "x") }), { condition = math })
mysnips[#mysnips+1] = s( { trig="loint", wordTrig=false, snippetType="autosnippet" }, fmta([[\oint_{<>} <> \, \mathrm{d}<>]],
{ i(1, "0"), i(2), i(3, "x") }), { condition = math })
mysnips[#mysnips+1] = s( { trig="lint", wordTrig=false, snippetType="autosnippet" }, fmta([[\int_{<>} <> \, \mathrm{d}<>]],
{ i(1, "0"), i(2), i(3, "x") }), { condition = math })
mysnips[#mysnips+1] = s( { trig="dint", wordTrig=false, snippetType="autosnippet" }, fmta([[\int <> \, \mathrm{d}<>]],
{ i(1), i(2, "x") }), { condition = math })

-- Derivatives
mysnips[#mysnips+1] = s( { trig="par", wordTrig=false, snippetType="autosnippet" }, fmta([[\frac{\partial <>}{\partial <>}]],
{ i(1, "y"), i(2, "x") }), { condition = math })
mysnips[#mysnips+1] = s( { trig="pa2", wordTrig=false, snippetType="autosnippet" }, fmta([[\frac{\partial^{2} <>}{\partial <>^{2}}]],
{ i(1, "y"), i(2, "x") }), { condition = math })
mysnips[#mysnips+1] = s( { trig="pa3", wordTrig=false, snippetType="autosnippet" }, fmta([[\frac{\partial^{3} <>}{\partial <>^{3}}]],
{ i(1, "y"), i(2, "x") }), { condition = math })
mysnips[#mysnips+1] = s( { trig="pa3", wordTrig=false, snippetType="autosnippet" }, fmta([[\frac{\partial^{3} <>}{\partial <>^{3}}]],
{ i(1, "y"), i(2, "x") }), { condition = math })

mysnips[#mysnips+1] = s( { trig="pa([A-Za-z])([A-Za-z])", regTrig=true }, fmta([[\frac{\partial <>}{\partial <>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="pa([A-Za-z])([A-Za-z])([A-Za-z])", regTrig=true }, fmta([[\frac{\partial^{2} <>}{\partial <> \partial <>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}), f(function(args, snip) return snip.captures[3] end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="pa([A-Za-z])([A-Za-z])_{2}", regTrig=true }, fmta([[\frac{\partial^{2} <>}{\partial <>^{2}}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="ddt", wordTrig=false, snippetType="autosnippet" }, t([[\frac{\mathrm{d}}{\mathrm{d}t}]]), { condition = math })

mysnips[#mysnips+1] = s( { trig="de([A-Za-z])([A-Za-z])", wordTrig=false, regTrig=true }, fmta([[\frac{\mathrm{d}<>}{\mathrm{d}<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="de([A-Za-z])([A-Za-z])_{2}", wordTrig=false, regTrig=true }, fmta([[\frac{\mathrm{d}^{2}<>}{\mathrm{d}<>^{2}}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}) }), { condition = math })

-- Trigonometry
for _, trig in ipairs({ "sin", "cos", "tan", "cot", "csc", "sec", "arccsc", "arcsec"}) do
	mysnips[#mysnips+1] = s({ trig=trig, wordTrig=false, snippetType="autosnippet" }, fmta("\\"..trig, {}), { condition = math })
end
mysnips[#mysnips+1] = s({ trig="arsi", wordTrig=false, snippetType="autosnippet" }, fmta("\\arcsin", {}), { condition = math })
mysnips[#mysnips+1] = s({ trig="arco", wordTrig=false, snippetType="autosnippet" }, fmta("\\arccos", {}), { condition = math })
mysnips[#mysnips+1] = s({ trig="arta", wordTrig=false, snippetType="autosnippet" }, fmta("\\arctan", {}), { condition = math })
mysnips[#mysnips+1] = s({ trig="arct", wordTrig=false, snippetType="autosnippet" }, fmta("\\arccot", {}), { condition = math })

-- Mathematical operations
mysnips[#mysnips+1] = s( { trig="sum", wordTrig=false, snippetType="autosnippet", priority=100 }, fmta([[\sum_{<>}^{<>}]],
{ i(1, "n=1"), i(2, "\\infty") }), { condition = math })
mysnips[#mysnips+1] = s( { trig="([a-z])sum", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta([[\sum_{<>=1}^{<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), i(1, "\\infty") }), { condition = math })

mysnips[#mysnips+1] = s( { trig="prod", wordTrig=false, snippetType="autosnippet" }, fmta([[\prod_{<>}^{<>}]],
{ i(1, "n=1"), i(2, "\\infty") }), { condition = math })

mysnips[#mysnips+1] = s( { trig="log", wordTrig=false, snippetType="autosnippet" }, fmta([[\log_{<>}]],
{ i(1) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="ln", wordTrig=false, snippetType="autosnippet" }, t("\\ln"), { condition = math })

mysnips[#mysnips+1] = s( { trig="lim", wordTrig=false, snippetType="autosnippet" }, fmta([[\lim_{<> \to <>}]],
{ i(1, "x"), i(2, "\\infty") }), { condition = math })
mysnips[#mysnips+1] = s( { trig="ilim", wordTrig=false, snippetType="autosnippet" }, fmta([[\lim\limits_{<> \to <>}]],
{ i(1, "x"), i(2, "\\infty") }), { condition = math })
for _,letter in ipairs({ "n", "x" }) do
	mysnips[#mysnips+1] = s( { trig=letter.."im", wordTrig=false, snippetType="autosnippet" }, fmta("\\lim_{"..letter.." \\to <>}",
	{ i(1, "\\infty") }), { condition = math })
	mysnips[#mysnips+1] = s( { trig="i"..letter.."im", wordTrig=false, snippetType="autosnippet" }, fmta("\\lim\\limits_{"..letter.." \\to <>}",
	{ i(1, "\\infty") }), { condition = math })
end
mysnips[#mysnips+1] = s( { trig="dlim", wordTrig=false, snippetType="autosnippet" }, fmta([[\lim_{\Delta x \to 0} \frac{<>}{\Delta x}]],
{ i(1, "\\Delta y") }), { condition = math })
mysnips[#mysnips+1] = s( { trig="idim", wordTrig=false, snippetType="autosnippet" }, fmta([[\lim\limits_{\Delta x \to 0} \frac{<>}{\Delta x}]],
{ i(1, "\\Delta y") }), { condition = math })

mysnips[#mysnips+1] = s( { trig="tayl", wordTrig=false, snippetType="autosnippet" }, fmta([[<>(<> + <>) = <>(<>) + <>'(<>)<> + <>''(<>) \frac{<>^{2}}{2!} + \dots]],
{ i(1, "f"), i(2, "x"), i(3, "h"), rep(1), rep(2), rep(1), rep(2), rep(3), rep(1), rep(2), rep(3) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="sr", wordTrig=false, snippetType="autosnippet" }, t([[^{2}]]), { condition = math })
mysnips[#mysnips+1] = s( { trig="cb", wordTrig=false, snippetType="autosnippet" }, t([[^{3}]]), { condition = math })
mysnips[#mysnips+1] = s( { trig="invs", wordTrig=false, snippetType="autosnippet" }, t([[^{-1}]]), { condition = math })

mysnips[#mysnips+1] = s( { trig="rd", wordTrig=false, snippetType="autosnippet" }, fmta([[^{<>}]],
{ i(1) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="ee", wordTrig=false, snippetType="autosnippet" }, fmta([[e^{<>}]],
{ i(1) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="conj", wordTrig=false, snippetType="autosnippet" }, t([[^{*}]]),
{ condition = math })
mysnips[#mysnips+1] = s( { trig="_", wordTrig=false, snippetType="autosnippet" }, fmta([[_{<>}]],
{ i(1) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="sts", wordTrig=false, snippetType="autosnippet" }, fmta([[_\mathrm{<>}]],
{ i(1) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="sq", wordTrig=false, snippetType="autosnippet" }, fmta([[\sqrt{<>}]],
{ i(1) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="sn", wordTrig=false, snippetType="autosnippet" }, fmta([[\sqrt[<>]{<>}]],

{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="//", wordTrig=false, snippetType="autosnippet" }, fmta([[\frac{<>}{<>}]],
{ i(1), i(2) }), { condition = math })

for _, letters in ipairs({ "f", "F", "g", "G" }) do
	mysnips[#mysnips+1] = s({ trig=letters:rep(2), wordTrig=false, snippetType="autosnippet" }, fmta(letters.."(<>)",
	{ i(1) }), { condition = math })
end

-- Letter modifications
for _, accents in ipairs({ "bar", "hat", "vec", "dot", "ddot", "tild", "und" }) do -- TODO: Fix ddot
	mysnips[#mysnips+1] = s({ trig=accents, wordTrig=false, snippetType="autosnippet", priority=100 }, fmta("\\"..accents.."{<>}",
	{ i(1) }), { condition = math })
	mysnips[#mysnips+1] = s({ trig="(%a)"..accents, wordTrig=false, regTrig=true, snippetType="autosnippet" }, fmta("\\"..accents.."{<>}",
	{ f(function(args, snip) return snip.captures[1] end, {}) }), { condition = math })
end

mysnips[#mysnips+1] = s({ trig="wd;", wordTrig=false, snippetType="autosnippet" }, fmta([[\widehat{<>}]],
{ i(1) }), { condition = math })
mysnips[#mysnips+1] = s({ trig="lv;", wordTrig=false, snippetType="autosnippet" }, fmta([[\overrightarrow{<>}]],
{ i(1) }), { condition = math })

-- Brackets
mysnips[#mysnips+1] = s({ trig="avg", wordTrig=false, snippetType="autosnippet" }, fmta([[\langle <> \rangle]],
{ i(1) }), { condition = math })
mysnips[#mysnips+1] = s({ trig="norm", wordTrig=false, snippetType="autosnippet" }, fmta([[\lvert <> \rvert]],
{ i(1) }), { condition = math })
mysnips[#mysnips+1] = s({ trig="mod", wordTrig=false, snippetType="autosnippet" }, fmta([[|<>|]],
{ i(1) }), { condition = math })

mysnips[#mysnips+1] = s({ trig="(", wordTrig=false, snippetType="autosnippet", priority=100 }, fmta([[(<>)]],
{ i(1) }), { condition = math })
--mysnips[#mysnips+1] = s({ trig="{", wordTrig=false, snippetType="autosnippet", priority=100 }, fmta([[{<>}]],
--{ i(1) }), { condition = math })

local brackets = {
	{ "(", "(", ")" },
	{ "s", "\\{", "\\}" },
	{ "|", "|", "|" },
	{ "[", "[", "]" },
	{ "a", "<<", ">>" },
	{ "f", "\\lfloor", "\\rfloor" },
	{ "c", "\\lceil", "\\rceil" },
}

for index = 1, #brackets, 1 do
	mysnips[#mysnips+1] = s({ trig="lr"..brackets[index][1], wordTrig=false, snippetType="autosnippet", priority=10000 }, fmta("\\left"..brackets[index][2].." <> ".."\\right"..brackets[index][3],
	{ i(1)}), { condition = math })
end

mysnips[#mysnips+1] = s({ trig="rl|", wordTrig=false, snippetType="autosnippet" }, fmta([[\left. <> \right|]],
{ i(1)}), { condition = math })

mysnips[#mysnips+1] = s({ trig = "lr.", wordTrig=false, snippetType="autosnippet" }, fmta([[
\left[ \;
\begin{array}{l}
<>
\end{array}
\right.
]], { i(1) }), { condition = math })

mysnips[#mysnips+1] = s({ trig = "mk", regTrig=true, snippetType = "autosnippet" }, fmta([[$<>$]],
{ i(1) }))
mysnips[#mysnips+1] = s({ trig = "([%s%.,;:\"])ьл", regTrig=true, snippetType = "autosnippet" }, fmta([[<>$<>$]],
{ f(function(args, snip) return snip.captures[1] end, {}), i(1) }))
mysnips[#mysnips+1] = s({ trig = "ьл", snippetType = "autosnippet" }, fmta([[$<>$]],
{ i(1) }), { condition = require("luasnip.extras.expand_conditions").line_begin })
mysnips[#mysnips+1] = ms({ common = { regTrig=true, snippetType = "autosnippet" }, "^dm", "^вь" }, fmta([[
$$
<>
$$
]], { i(1) }))

mysnips[#mysnips+1] = s({ trig = "beg", wordTrig=false, snippetType = "autosnippet" }, fmta([[
\begin{<>}
<>
\end{<>}
]], { i(1), i(2), rep(1) }), { condition = math })

mysnips[#mysnips+1] = s({ trig = "aram", wordTrig=false, snippetType = "autosnippet" }, fmta([[
\left( \begin{array}{<>}
<>
\end{array} \right) ]], { i(1), i(2) }), { condition = math })

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

local SYMBOLS = require("custom.latex_symbols")
local GREEK = { "alpha", "beta", "gamma", "Gamma", "delta", "Delta", "epsilon", "varepsilon", "zeta", "eta",
"theta", "Theta", "iota", "kappa", "lambda", "Lambda", "mu", "nu", "omicron", "xi", "Xi", "pi", "Pi", "rho",
"sigma", "Sigma", "tau", "upsilon", "Upsilon", "varphi", "phi", "Phi", "chi", "psi", "Psi", "omega", "Omega" }
local TRIG = { "sin", "cos", "tan", "cot", "arcsin", "arccos", "arctan", "arccot", "sinh", "cosh", "tanh", "coth" }

-- Fraction
local auto_fraction = require("function.autofraction")

local breaking_chars = "%(%[{%$%+%-=;:<>"

mysnips[#mysnips+1] = s( { trig= "(.*[^%s.."..breaking_chars.."]+)/", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta([[<>{<>}]],
{ f(function(args, snip)
	local cursor_pos, _ = snip.snippet:get_buf_position()
	local line_to_snip = vim.api.nvim_buf_get_text(0, cursor_pos[1], 0, cursor_pos[1], cursor_pos[2], {})
	local line_to_cursor = line_to_snip[1]..snip.captures[1]

	local start, to = auto_fraction(line_to_cursor)

	vim.notify("Capture: "..snip.captures[1])

	return line_to_cursor:sub(1, start-1).."\\frac{"..line_to_cursor:sub(start, to).."}"
end, {}), i(1) }), { condition = math })

-- Auto enlarge brackets

local triggers = { "sum", "int", "frac", "prod", "bigcup", "bigcap" }


-- Spacing
for _, symbol in ipairs(SYMBOLS) do
	mysnips[#mysnips+1] = s( { trig=symbol.."(%a)", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta(symbol.." <>",
	{ f(function(args, snip) return snip.captures[1] end, {}) }), { condition = math })
	mysnips[#mysnips+1] = s( { trig=symbol.."(%d)", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta(symbol.."<>",
	{ f(function(args, snip) return snip.captures[1] end, {}) }), { condition = math })

	mysnips[#mysnips+1] = s( { trig=symbol.." sr", regTrig=true, wordTrig=false, snippetType="autosnippet", priority = 10000 }, t(symbol.."^{2}"), { condition = math })
	mysnips[#mysnips+1] = s( { trig=symbol.." cb", regTrig=true, wordTrig=false, snippetType="autosnippet", priority = 10000 }, t(symbol.."^{3}"), { condition = math })
	mysnips[#mysnips+1] = s( { trig=symbol.." rd", regTrig=true, wordTrig=false, snippetType="autosnippet", priority = 10000 }, fmta(symbol.."^{<>}",
	{ i(1) }), { condition = math })

	for _, accents in ipairs({ "hat", "dot", "bar", "vec", "tild", "und" }) do
		mysnips[#mysnips+1] = s( { trig=symbol.." "..accents, regTrig=true, wordTrig=false, snippetType="autosnippet" }, t("\\"..accents.."{"..symbol.."}"), { condition = math })
	end
end

for _, greek in ipairs(SYMBOLS) do
	mysnips[#mysnips+1] = s( { trig=greek..",.", regTrig=true, wordTrig=false, snippetType="autosnippet" }, t("\\boldsymbol{"..greek.."}"), { condition = math })
end

-- Space and trigonometry
for _, trig in ipairs(TRIG) do
	mysnips[#mysnips+1] = s( { trig=trig.." sr", regTrig=true, wordTrig=false, snippetType="autosnippet", priority = 10000 }, t(trig.."^{2}"), { condition = math })
	mysnips[#mysnips+1] = s( { trig=trig.." cb", regTrig=true, wordTrig=false, snippetType="autosnippet", priority = 10000 }, t(trig.."^{3}"), { condition = math })
	mysnips[#mysnips+1] = s( { trig=trig.." rd", regTrig=true, wordTrig=false, snippetType="autosnippet", priority = 10000 }, fmta(trig.."^{<>}",
	{ i(1) }), { condition = math })
end

for _, trig in ipairs({ "sin", "cos", "tan", "cot", "csc", "sec", "arccsc", "arcsec"}) do
	mysnips[#mysnips+1] = s({ trig="\\"..trig.."([A-Za-gi-z0-9])", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta("\\"..trig.." <>",
	{ f(function(args, snip) return snip.captures[1] end, {}) }), { condition = math })
end
for _, htrig in ipairs({ "sinh", "cosh", "tanh", "coth" }) do
	mysnips[#mysnips+1] = s({ trig="\\"..htrig.."(%w)", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta("\\"..htrig.." <>",
	{ f(function(args, snip) return snip.captures[1] end, {}) }), { condition = math })
end

-- Subscripts
mysnips[#mysnips+1] = s( { trig="(%a)(%d)", regTrig=true, wordTrig=false, snippetType="autosnippet", priority=10000 }, fmta([[<>_{<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="\\hat{(%a)}(%d)", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta([[\hat{<>}_{<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="\\mathbf{(%a)}(%d)", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta([[\mathbf{<>}_{<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="\\vec{(%a)}(%d)", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta([[\vec{<>}_{<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}) }), { condition = math })

for _, letters in ipairs({ "i", "j", "n", "m", "k", "y"}) do
	mysnips[#mysnips+1] = s( { trig="(%a)"..letters:rep(2), wordTrig=false, regTrig=true, snippetType="autosnippet" }, fmta("<>_".."{"..letters.."}",
	{ f(function(args, snip) return snip.captures[1] end, {}) }), { condition = math })
end

mysnips[#mysnips+1] = s( { trig="(%a)(%a)p(%d)", wordTrig=false, regTrig=true, snippetType="autosnippet" }, fmta([[<>_{<>+<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}), f(function(args, snip) return snip.captures[3] end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="(%a)(%a)m(%d)", wordTrig=false, regTrig=true, snippetType="autosnippet" }, fmta([[<>_{<>-<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}), f(function(args, snip) return snip.captures[3] end, {}) }), { condition = math })

-- Unit vectors
for _, letters in ipairs({ "i", "n", "j", "k"}) do
	mysnips[#mysnips+1] = s( { trig=":"..letters, wordTrig=false, regTrig=true, snippetType="autosnippet" }, t("\\mathbf{"..letters.."}"), { condition = math })
end
for _, letters in ipairs({ "x", "y", "z"}) do
	mysnips[#mysnips+1] = s( { trig=":"..letters, wordTrig=false, regTrig=true, snippetType="autosnippet" }, t("\\hat{\\mathbf{"..letters.."}}"), { condition = math })
end

-- Spacing
mysnips[#mysnips+1] = s( { trig="qd", wordTrig=false, snippetType="autosnippet" }, t([[\quad]]), { condition = math })
mysnips[#mysnips+1] = s( { trig="qqd", wordTrig=false, snippetType="autosnippet" }, t([[\qquad]]), { condition = math })

mysnips[#mysnips+1] = s( { trig=",,", wordTrig=false, snippetType="autosnippet" }, t([[,\,]]), { condition = math })
mysnips[#mysnips+1] = s( { trig=";;", wordTrig=false, snippetType="autosnippet" }, t([[;\;]]), { condition = math })
mysnips[#mysnips+1] = s( { trig=";,", wordTrig=false, snippetType="autosnippet" }, t([[;\,]]), { condition = math })
mysnips[#mysnips+1] = s( { trig="]]", wordTrig=false, snippetType="autosnippet" }, t([[\;]]), { condition = math })

mysnips[#mysnips+1] = s({ trig="hsp", wordTrig=false, snippetType="autosnippet" }, fmta([[\hspace{<>}]],
{ i(1) }), { condition = math })
mysnips[#mysnips+1] = ms({common = { wordTrig=false, snippetType="autosnippet" }, "qp", "pq" }, fmta([[\\

]], {}), { condition = math })

--Text
mysnips[#mysnips+1] = s( { trig="text", wordTrig=false, snippetType="autosnippet" }, fmta([[\text{<>}]],
{ i(1) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="bf", wordTrig=false, snippetType="autosnippet" }, fmta([[\mathbf{<>}]],
{ i(1) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="rm", wordTrig=false, snippetType="autosnippet", priority=100 }, fmta([[\mathrm{<>}]],
{ i(1) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="mcal", wordTrig=false, snippetType="autosnippet" }, fmta([[\mathcal{<>}]],
{ i(1) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="mbb", wordTrig=false, snippetType="autosnippet" }, fmta([[\mathbb{<>}]],
{ i(1) }), { condition = math })

-- Letters
for _, letters in ipairs({ "H", "L", "A", "B"}) do
	mysnips[#mysnips+1] = s({ trig=letters:rep(2), wordTrig=false, snippetType="autosnippet" }, t("\\mathcal{"..letters.."}"), { condition = math })
end
for _, letters in ipairs({ "C", "I", "R", "Q", "Z", "N"}) do
	mysnips[#mysnips+1] = s({ trig=letters:rep(2), wordTrig=false, snippetType="autosnippet" }, t("\\mathbb{"..letters.."}"), { condition = math })
end

mysnips[#mysnips+1] = s( { trig="re", snippetType="autosnippet", priority=100 }, t([[\mathrm{Re}]]), { condition = math })
mysnips[#mysnips+1] = s( { trig="im", snippetType="autosnippet", priority=100 }, t([[\mathrm{Im}]]), { condition = math })

-- Misc
mysnips[#mysnips+1] = s( { trig="`-", wordTrig=false, snippetType="autosnippet" }, t([[\hline]]), { condition = math })
mysnips[#mysnips+1] = s( { trig="hh", wordTrig=false, snippetType="autosnippet" }, fmta([[{\huge <>}]],
{ i(1) }), { condition = math })

-- Visual operations
mysnips[#mysnips+1] = s( { trig="/", regTrig=true, wordTrig=false }, fmta([[\frac{<>}{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}), i(1) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="b", regTrig=true, wordTrig=false }, fmta([[\underbrace{<>}_{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}), i(1) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="B", regTrig=true, wordTrig=false }, fmta([[\underbrace{<>}^{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}), i(1) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="s", regTrig=true, wordTrig=false }, fmta([[\overset{<>}{<>}]],
{ i(1), f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="S", regTrig=true, wordTrig=false }, fmta([[\underset{<>}{<>}]],
{ i(1), f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="l", regTrig=true, wordTrig=false }, fmta([[\underline{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="L", regTrig=true, wordTrig=false }, fmta([[\overline{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="c", regTrig=true, wordTrig=false }, fmta([[\cancel{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="k", regTrig=true, wordTrig=false }, fmta([[\cancelto{<>}{<>}]],
{ i(1), f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="r", regTrig=true, wordTrig=false }, fmta([[\sqrt{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="x", regTrig=true, wordTrig=false }, fmta([[\boxed{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })

-- Colours

mysnips[#mysnips+1] = s( { trig="@m", regTrig=true, wordTrig=false, priority = 10000 }, fmta([[{\color{rmage}<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="@v", regTrig=true, wordTrig=false, priority = 10000 }, fmta([[{\color{rviol}<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="@b", regTrig=true, wordTrig=false, priority = 10000 }, fmta([[{\color{rblue}<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="@c", regTrig=true, wordTrig=false, priority = 10000 }, fmta([[{\color{rcyan}<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="@l", regTrig=true, wordTrig=false, priority = 10000 }, fmta([[{\color{rlime}<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="@p", regTrig=true, wordTrig=false, priority = 10000 }, fmta([[{\color{rpuke}<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="@o", regTrig=true, wordTrig=false, priority = 10000 }, fmta([[{\color{rorng}<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="@r", regTrig=true, wordTrig=false, priority = 10000 }, fmta([[{\color{rred}<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="@g", regTrig=true, wordTrig=false, priority = 10000 }, fmta([[{\color{rgren}<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="ex", regTrig=true, wordTrig=false, priority = 10000 }, fmta([[\ex{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })

return mysnips
