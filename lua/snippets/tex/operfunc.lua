local math = require("function.mathzone")

local mysnips = {}

-- Integrals
for index = 1, 3, 1 do
	mysnips[#mysnips+1] = s({ trig=("i"):rep(index).."nt", wordTrig=false, snippetType="autosnippet", priority = 100 }, fmta("\\"..("i"):rep(index).."nt_{<>}^{<>} <> \\, \\mathrm{d}<> <>",
	{ i(1, "0"), i(2, "\\infty"), i(3), i(4, "x"), i(5) }), { condition = math })
end

mysnips[#mysnips+1] = s( { trig="lint", wordTrig=false, snippetType="autosnippet" }, fmta([[\int_{<>} <> \, \mathrm{d}<><>]],
{ i(1, "0"), i(2), i(3, "x"), i(4) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="oint", wordTrig=false, snippetType="autosnippet" }, fmta([[\oint_{<>}^{<>} <> \, \mathrm{d}<><>]],
{ i(1, "0"), i(2, "\\infty"), i(3), i(4, "x"), i(5) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="loint", wordTrig=false, snippetType="autosnippet" }, fmta([[\oint_{<>} <> \, \mathrm{d}<><>]],
{ i(1, "0"), i(2), i(3, "x"), i(4) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="lint", wordTrig=false, snippetType="autosnippet" }, fmta([[\int_{<>} <> \, \mathrm{d}<><>]],
{ i(1, "0"), i(2), i(3, "x"), i(4) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="dint", wordTrig=false, snippetType="autosnippet" }, fmta([[\int <> \, \mathrm{d}<><>]],
{ i(1), i(2, "x"), i(3) }), { condition = math })

-- Derivatives
mysnips[#mysnips+1] = s( { trig="par", wordTrig=false, snippetType="autosnippet" }, fmta([[\frac{\partial <>}{\partial <>}<>]],
{ i(1, "y"), i(2, "x"), i(3) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="pa2", wordTrig=false, snippetType="autosnippet" }, fmta([[\frac{\partial^{2} <>}{\partial <>^{2}}<>]],
{ i(1, "y"), i(2, "x"), i(3) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="pa3", wordTrig=false, snippetType="autosnippet" }, fmta([[\frac{\partial^{3} <>}{\partial <>^{3}}<>]],
{ i(1, "y"), i(2, "x"), i(3) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="pa3", wordTrig=false, snippetType="autosnippet" }, fmta([[\frac{\partial^{3} <>}{\partial <>^{3}}<>]],
{ i(1, "y"), i(2, "x"), i(3) }), { condition = math })

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
mysnips[#mysnips+1] = s( { trig="sum", wordTrig=false, snippetType="autosnippet" }, fmta([[\sum_{<>}^{<>}<>]],
{ i(1, "n=1"), i(2, "\\infty"), i(3) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="([a-z])sum", regTrig=true, wordTrig=false, snippetType="autosnippet" }, fmta([[\sum_{<>=1}^{<>} <>]],
{ f(function(args, snip) return snip.captures[1] end, {}), i(2, "\\infty"), i(3) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="prod", wordTrig=false, snippetType="autosnippet" }, fmta([[\prod_{<>}^{<>}<>]],
{ i(1, "n=1"), i(2, "\\infty"), i(3) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="log", wordTrig=false, snippetType="autosnippet" }, fmta([[\log_{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="ln", wordTrig=false, snippetType="autosnippet" }, t("\\ln"), { condition = math })

mysnips[#mysnips+1] = s( { trig="lim", wordTrig=false, snippetType="autosnippet" }, fmta([[\lim_{<> \to <>}<>]],
{ i(1, "x"), i(2, "\\infty"), i(3) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="ilim", wordTrig=false, snippetType="autosnippet" }, fmta([[\lim\limits_{<> \to <>}<>]],
{ i(1, "x"), i(2, "\\infty"), i(3) }), { condition = math })
for _,letter in ipairs({ "n", "x" }) do
	mysnips[#mysnips+1] = s( { trig=letter.."im", wordTrig=false, snippetType="autosnippet" }, fmta("\\lim_{"..letter.." \\to <>}<>",
	{ i(1, "\\infty"), i(2) }), { condition = math })
	mysnips[#mysnips+1] = s( { trig="i"..letter.."im", wordTrig=false, snippetType="autosnippet" }, fmta("\\lim\\limits_{"..letter.." \\to <>}<>",
	{ i(1, "\\infty"), i(2) }), { condition = math })
end
mysnips[#mysnips+1] = s( { trig="dlim", wordTrig=false, snippetType="autosnippet" }, fmta([[\lim_{\Delta x \to 0} \frac{<>}{\Delta x}<>]],
{ i(1, "\\Delta y"), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="idim", wordTrig=false, snippetType="autosnippet" }, fmta([[\lim\limits_{\Delta x \to 0} \frac{<>}{\Delta x}<>]],
{ i(1, "\\Delta y"), i(2) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="tayl", wordTrig=false, snippetType="autosnippet" }, fmta([[<>(<> + <>) = <>(<>) + <>'(<>)<> + <>''(<>) \frac{<>^{2}}{2!} + \dots<>]],
{ i(1, "f"), i(2, "x"), i(3, "h"), rep(1), rep(2), rep(1), rep(2), rep(3), rep(1), rep(2), rep(3), i(4) }), { condition = math })

return mysnips
