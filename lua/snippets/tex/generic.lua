local math = require("function.mathzone")

local mysnips = {}

mysnips[#mysnips+1] = s( { trig="sr", wordTrig=false, snippetType="autosnippet" }, t([[^{2}]]), { condition = math })
mysnips[#mysnips+1] = s( { trig="cb", wordTrig=false, snippetType="autosnippet" }, t([[^{3}]]), { condition = math })
mysnips[#mysnips+1] = s( { trig="invs", wordTrig=false, snippetType="autosnippet" }, t([[^{-1}]]), { condition = math })

mysnips[#mysnips+1] = s( { trig="rd", wordTrig=false, snippetType="autosnippet" }, fmta([[^{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="ee", wordTrig=false, snippetType="autosnippet" }, fmta([[e^{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="conj", wordTrig=false, snippetType="autosnippet" }, t([[^{*}]]),
{ condition = math })
mysnips[#mysnips+1] = s( { trig="_", wordTrig=false, snippetType="autosnippet" }, fmta([[_{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="sts", wordTrig=false, snippetType="autosnippet" }, fmta([[_\mathrm{<>}<>]],
{ i(1), i(2) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="sq", wordTrig=false, snippetType="autosnippet" }, fmta([[\sqrt{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="sn", wordTrig=false, snippetType="autosnippet" }, fmta([[\sqrt[<>]{<>}<>]],

{ i(1), i(2), i(3) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="//", wordTrig=false, snippetType="autosnippet" }, fmta([[\frac{<>}{<>}<>]],
{ i(1), i(2), i(3) }), { condition = math })

for _, letters in ipairs({ "f", "F", "g", "G" }) do
	mysnips[#mysnips+1] = s({ trig=letters:rep(2), wordTrig=false, snippetType="autosnippet" }, fmta(letters.."(<>)",
	{ i(1) }), { condition = math })
end

-- Letter modifications
for _, accents in ipairs({ "bar", "hat", "vec", "dot", "ddot", "tild", "und" }) do -- TODO: Fix ddot
	mysnips[#mysnips+1] = s({ trig=accents, wordTrig=false, snippetType="autosnippet", priority=100 }, fmta("\\"..accents.."{<>}<>",
	{ i(1), i(2) }), { condition = math })
	mysnips[#mysnips+1] = s({ trig="(%a)"..accents, wordTrig=false, regTrig=true, snippetType="autosnippet" }, fmta("\\"..accents.."{<>}",
	{ f(function(args, snip) return snip.captures[1] end, {}) }), { condition = math })
end

mysnips[#mysnips+1] = s({ trig="wd;", wordTrig=false, snippetType="autosnippet" }, fmta([[\widehat{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s({ trig="lv;", wordTrig=false, snippetType="autosnippet" }, fmta([[\overrightarrow{<>}<>]],
{ i(1), i(2) }), { condition = math })

-- Brackets
mysnips[#mysnips+1] = s({ trig="avg", wordTrig=false, snippetType="autosnippet" }, fmta([[\langle <> \rangle<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s({ trig="norm", wordTrig=false, snippetType="autosnippet" }, fmta([[\lvert <> \rvert<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s({ trig="mod", wordTrig=false, snippetType="autosnippet" }, fmta([[|<>|<>]],
{ i(1), i(2) }), { condition = math })

mysnips[#mysnips+1] = s({ trig="(", wordTrig=false, snippetType="autosnippet", priority=100 }, fmta([[(<>)<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s({ trig="{", wordTrig=false, snippetType="autosnippet", priority=100 }, fmta([[{<>}<>]],
{ i(1), i(2) }), { condition = math })

local brackets = {
	{ "(", "(", ")" },
	{ "{", "{", "}" },
	{ "|", "|", "|" },
	{ "[", "[", "]" },
	{ "a", "<<", ">>" },
	{ "f", "\\lfloor", "\\rfloor" },
	{ "c", "\\lceil", "\\rceil" },
}

for index = 1, #brackets, 1 do
	mysnips[#mysnips+1] = s({ trig="lr"..brackets[index][1], wordTrig=false, snippetType="autosnippet" }, fmta("\\left"..brackets[index][2].." <> ".."\\right"..brackets[index][3].." <>",
	{ i(1), i(2)}), { condition = math })
end

mysnips[#mysnips+1] = s({ trig="rl|", wordTrig=false, snippetType="autosnippet" }, fmta([[\left. <> \right|<>]],
{ i(1), i(2)}), { condition = math })

mysnips[#mysnips+1] = s({ trig = "lr.", wordTrig=false, snippetType="autosnippet" }, fmta([[
\left[ \;
\begin{array}{l}
<>
\end{array}
\right.
]], { i(1) }), { condition = math })

return mysnips
