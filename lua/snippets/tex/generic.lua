local math = require("snippets.helper_functions")

local mysnips = {}

mysnips[#mysnips+1] = s( { trig="text", snippetType="autosnippet" }, fmta([[\text{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="bf", wordTrig=false, snippetType="autosnippet" }, fmta([[\mathbf{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="rm", wordTrig=false, snippetType="autosnippet", priority=100 }, fmta([[\mathrm{<>}<>]],
{ i(1), i(2) }), { condition = math })

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

--

mysnips[#mysnips+1] = s( { trig="arg", wordTrig=false, snippetType="autosnippet" }, t([[\arg]]))
mysnips[#mysnips+1] = s( { trig="det", wordTrig=false, snippetType="autosnippet" }, t([[\det]]))

mysnips[#mysnips+1] = s( { trig="re", wordTrig=false, snippetType="autosnippet", priority=100 }, t([[\mathrm{Re}]]))
mysnips[#mysnips+1] = s( { trig="im", wordTrig=false, snippetType="autosnippet", priority=100 }, t([[\mathrm{Im}]]))

--
for _, letters in ipairs({ "f", "F", "g", "G" }) do
	mysnips[#mysnips+1] = s({ trig=letters:rep(2), wordTrig=false, snippetType="autosnippet" }, fmta(letters.."(<>)",
	{ i(1) }), { condition = math })
end

mysnips[#mysnips+1] = s({ trig="set", wordTrig=false, snippetType="autosnippet" }, fmta([[{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="trace", wordTrig=false, snippetType="autosnippet" }, fmta([[\mathrm{Tr}(<>)<>]],
{ i(1), i(2) }), { condition = math })

-- Letter modifications
for _, accents in ipairs({ "bar", "hat", "vec", "dot", "ddot" }) do -- TODO: Fix ddot
	mysnips[#mysnips+1] = s({ trig="(%a)"..accents, wordTrig=false, regTrig=true, snippetType="autosnippet" }, fmta("\\"..accents.."{<>}",
	{ f(function(args, snip) return snip.captures[1] end, {}) }), { condition = math })
	mysnips[#mysnips+1] = s({ trig=accents, wordTrig=false, snippetType="autosnippet" }, fmta("\\"..accents.."{<>}<>",
	{ i(1), i(2) }), { condition = math })
end

mysnips[#mysnips+1] = s({ trig="tild", wordTrig=false, snippetType="autosnippet" }, fmta([[\tilde{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="([a-zA-Z])tild", wordTrig=false, regTrig=true, snippetType="autosnippet" }, fmta([[\tilde{<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}) }), { condition = math })
mysnips[#mysnips+1] = s({ trig="und", wordTrig=false, snippetType="autosnippet" }, fmta([[\und{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="([a-zA-Z])und", wordTrig=false, regTrig=true, snippetType="autosnippet" }, fmta([[\und{<>}]],
{ f(function(args, snip) return snip.captures[1] end, {}) }), { condition = math })

mysnips[#mysnips+1] = s({ trig="wd;", wordTrig=false, snippetType="autosnippet" }, fmta([[\widehat{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s({ trig="lv;", wordTrig=false, snippetType="autosnippet" }, fmta([[\overrightarrow{<>}<>]],
{ i(1), i(2) }), { condition = math })

-- Subscripts
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

-- Brackets
mysnips[#mysnips+1] = s({ trig="avg", wordTrig=false, snippetType="autosnippet" }, fmta([[\langle <> \rangle <>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s({ trig="norm", wordTrig=false, snippetType="autosnippet" }, fmta([[\lvert <> \rvert <>]],
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

mysnips[#mysnips+1] = s({ trig = "lr.", snippetType = "autosnippet" }, fmta([[
\left[ \;
\begin{array}{l}
<>
\end{array}
\right.
]], { i(1) }), { condition = math })

return mysnips
