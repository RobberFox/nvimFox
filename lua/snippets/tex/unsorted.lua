local math = require("function.mathzone")

local mysnips = {}

-- Spacing
mysnips[#mysnips+1] = s( { trig="qd", wordTrig=false, snippetType="autosnippet" }, t([[\quad]]), { condition = math })
mysnips[#mysnips+1] = s( { trig="qqd", wordTrig=false, snippetType="autosnippet" }, t([[\qquad]]), { condition = math })

mysnips[#mysnips+1] = s( { trig=",,", wordTrig=false, snippetType="autosnippet" }, t([[,\,]]), { condition = math })
mysnips[#mysnips+1] = s( { trig=";;", wordTrig=false, snippetType="autosnippet" }, t([[;\;]]), { condition = math })
mysnips[#mysnips+1] = s( { trig=";,", wordTrig=false, snippetType="autosnippet" }, t([[;\,]]), { condition = math })
mysnips[#mysnips+1] = s( { trig="]]", wordTrig=false, snippetType="autosnippet" }, t([[\;]]), { condition = math })

mysnips[#mysnips+1] = s({ trig="hsp", wordTrig=false, snippetType="autosnippet" }, fmta([[\hspace{<>} <>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = ms({common = { wordTrig=false, snippetType="autosnippet" }, "qp", "pq" }, fmta([[\\

]], {}), { condition = math })

--Text
mysnips[#mysnips+1] = s( { trig="text", wordTrig=false, snippetType="autosnippet" }, fmta([[\text{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="bf", wordTrig=false, snippetType="autosnippet" }, fmta([[\mathbf{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="rm", wordTrig=false, snippetType="autosnippet", priority=100 }, fmta([[\mathrm{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="mcal", wordTrig=false, snippetType="autosnippet" }, fmta([[\mathcal{<>}<>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="mbb", wordTrig=false, snippetType="autosnippet" }, fmta([[\mathbb{<>}<>]],
{ i(1), i(2) }), { condition = math })

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
mysnips[#mysnips+1] = s( { trig="hh", wordTrig=false, snippetType="autosnippet" }, fmta([[{\huge <>}<>]],
{ i(1), i(2) }), { condition = math })

return mysnips
