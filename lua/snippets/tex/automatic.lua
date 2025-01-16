local math = require("function.mathzone")

local SYMBOLS = require("custom.latex_symbols")
local GREEK = { "alpha", "beta", "gamma", "Gamma", "delta", "Delta", "epsilon", "varepsilon", "zeta", "eta",
"theta", "Theta", "iota", "kappa", "lambda", "Lambda", "mu", "nu", "omicron", "xi", "Xi", "pi", "Pi", "rho",
"sigma", "Sigma", "tau", "upsilon", "Upsilon", "varphi", "phi", "Phi", "chi", "psi", "Psi", "omega", "Omega" }
local TRIG = { "sin", "cos", "tan", "cot", "arcsin", "arccos", "arctan", "arccot", "sinh", "cosh", "tanh", "coth" }

local mysnips = {}

-- Fraction
-- TODO: Fraction with parentheses `(1 + 2)` -> `\frac{1 + 2}{}`
mysnips[#mysnips+1] = s({ trig="((\\d+)|(\\d*)(\\\\)?([A-Za-z]+)((\\^|_)(\\{\\d+\\}|\\d))*)\\/", regTrig=true, wordTrig=false, trigEngine="ecma", snippetType="autosnippet" }, fmta([[\frac{<>}{<>}<>]],
{ f(function(args, snip) return snip.captures[1] end, {}), i(1), i(2) }), { condition = math })

-- Auto enlarge brackets
local auto_enlarge = require("function.enlarge_brackets")
mysnips[#mysnips+1] = s({ trig="lig" }, {  f(function()
	auto_enlarge()
end) })

-- Spacing
for _, symbol in ipairs(SYMBOLS) do
	mysnips[#mysnips+1] = s({ trig=symbol.."(%a)", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta(symbol.." <>",
	{ f(function(args, snip) return snip.captures[1] end, {}) }), { condition = math })

	mysnips[#mysnips+1] = s({ trig=symbol.." sr", regTrig=true, wordTrig=false, snippetType="autosnippet" }, t(symbol.."^{2}"), { condition = math })
	mysnips[#mysnips+1] = s({ trig=symbol.." cb", regTrig=true, wordTrig=false, snippetType="autosnippet" }, t(symbol.."^{3}"), { condition = math })
	mysnips[#mysnips+1] = s({ trig=symbol.." rd", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta(symbol.."^{<>}<>",
	{ i(1), i(2) }), { condition = math })

	for _, accents in ipairs({ "hat", "dot", "bar", "vec", "tild", "und" }) do
		mysnips[#mysnips+1] = s({ trig=symbol.." "..accents, regTrig=true, wordTrig=false, snippetType="autosnippet" }, t("\\"..accents.."{"..symbol.."}"), { condition = math })
	end
end

for _, greek in ipairs(SYMBOLS) do
	mysnips[#mysnips+1] = s({ trig=greek..",.", regTrig=true, wordTrig=false, snippetType="autosnippet" }, t("\\boldsymbol{"..greek.."}"), { condition = math })
end

-- Space and trigonometry
for _, trig in ipairs(TRIG) do
	mysnips[#mysnips+1] = s({ trig=trig.." sr", regTrig=true, wordTrig=false, snippetType="autosnippet" }, t(trig.."^{2}"), { condition = math })
	mysnips[#mysnips+1] = s({ trig=trig.." cb", regTrig=true, wordTrig=false, snippetType="autosnippet" }, t(trig.."^{3}"), { condition = math })
	mysnips[#mysnips+1] = s({ trig=trig.." rd", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta(trig.."^{<>}<>",
	{ i(1), i(2) }), { condition = math })
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
mysnips[#mysnips+1] = s({ trig="(%a)(%d)", regTrig=true, wordTrig=false, snippetType="autosnippet", priority=100 }, fmta([[<>_{<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}) }), { condition = math })
mysnips[#mysnips+1] = s({ trig="\\hat{(%a)}(%d)", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta([[\hat{<>}_{<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}) }), { condition = math })
mysnips[#mysnips+1] = s({ trig="\\mathbf{(%a)}(%d)", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta([[\mathbf{<>}_{<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}) }), { condition = math })
mysnips[#mysnips+1] = s({ trig="\\vec{(%a)}(%d)", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta([[\vec{<>}_{<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}) }), { condition = math })

for _, letters in ipairs({ "i", "j", "n", "m", "k", "y"}) do
	mysnips[#mysnips+1] = s({ trig="(%a)"..letters:rep(2), wordTrig=false, regTrig=true, snippetType="autosnippet" }, fmta("<>_".."{"..letters.."}",
	{ f(function(args, snip) return snip.captures[1] end, {}) }), { condition = math })
end

mysnips[#mysnips+1] = s({ trig="(%a)(%a)p(%d)", wordTrig=false, regTrig=true, snippetType="autosnippet" }, fmta([[<>_{<>+<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}), f(function(args, snip) return snip.captures[3] end, {}) }), { condition = math })
mysnips[#mysnips+1] = s({ trig="(%a)(%a)m(%d)", wordTrig=false, regTrig=true, snippetType="autosnippet" }, fmta([[<>_{<>-<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}), f(function(args, snip) return snip.captures[2] end, {}), f(function(args, snip) return snip.captures[3] end, {}) }), { condition = math })

-- Unit vectors
for _, letters in ipairs({ "i", "n", "j", "k"}) do
	mysnips[#mysnips+1] = s({ trig=":"..letters, wordTrig=false, regTrig=true, snippetType="autosnippet" }, t("\\mathbf{"..letters.."}"), { condition = math })
end
for _, letters in ipairs({ "x", "y", "z"}) do
	mysnips[#mysnips+1] = s({ trig=":"..letters, wordTrig=false, regTrig=true, snippetType="autosnippet" }, t("\\hat{\\mathbf{"..letters.."}}"), { condition = math })
end

return mysnips
