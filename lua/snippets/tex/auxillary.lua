local math = require("snippets.helper_functions")

local mysnips = {}

-- Spacing
mysnips[#mysnips+1] = s( { trig="qd", snippetType="autosnippet" }, t([[\quad]]), { condition = math })
mysnips[#mysnips+1] = s( { trig="qqd", snippetType="autosnippet" }, t([[\qquad]]), { condition = math })

mysnips[#mysnips+1] = s( { trig=",,", snippetType="autosnippet" }, t([[,\,]]), { condition = math })
mysnips[#mysnips+1] = s( { trig=";;", snippetType="autosnippet" }, t([[;\;]]), { condition = math })
mysnips[#mysnips+1] = s( { trig=";,", snippetType="autosnippet" }, t([[;\,]]), { condition = math })
mysnips[#mysnips+1] = s( { trig="]]", snippetType="autosnippet" }, t([[\;]]), { condition = math })

mysnips[#mysnips+1] = s({ trig="hsp", wordTrig=false, snippetType="autosnippet" }, fmta([[\hspace{<>} <>]],
{ i(1), i(2) }), { condition = math })
mysnips[#mysnips+1] = ms({common = { wordTrig=false, snippetType="autosnippet" }, "qp", "pq" }, fmta([[\\

]], {}), { condition = math })

-- Misc
mysnips[#mysnips+1] = s( { trig="`-", snippetType="autosnippet" }, t([[\hline]]), { condition = math })
mysnips[#mysnips+1] = s( { trig="hh", snippetType="autosnippet" }, fmta([[{\huge <>} <>]],
{ i(1), i(2) }), { condition = math })

return mysnips
