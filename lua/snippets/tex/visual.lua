local math = require("function.mathzone")

local mysnips = {}

-- Fraction
mysnips[#mysnips+1] = s( { trig="/", regTrig=true, wordTrig=false }, fmta([[\frac{<>}{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}), i(1) }), { condition = math })

-- Visual operations
mysnips[#mysnips+1] = s( { trig="b", regTrig=true, wordTrig=false }, fmta([[\underbrace{<>}_{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}), i(1) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="B", regTrig=true, wordTrig=false }, fmta([[\underbrace{<>}^{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}), i(1) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="s", regTrig=true, wordTrig=false }, fmta([[\overset{<>}{<>}<>]],
{ i(1), f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}), i(2) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="S", regTrig=true, wordTrig=false }, fmta([[\underset{<>}{<>}<>]],
{ i(1), f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}), i(2) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="l", regTrig=true, wordTrig=false }, fmta([[\underline{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="L", regTrig=true, wordTrig=false }, fmta([[\overline{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="c", regTrig=true, wordTrig=false }, fmta([[\cancel{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="k", regTrig=true, wordTrig=false }, fmta([[\cancelto{<>}{<>}<>]],
{ i(1), f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}), i(2) }), { condition = math })

mysnips[#mysnips+1] = s( { trig="r", regTrig=true, wordTrig=false }, fmta([[\sqrt{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })
mysnips[#mysnips+1] = s( { trig="x", regTrig=true, wordTrig=false }, fmta([[\boxed{<>}]],
{ f(function(args, snip) return snip.env.TM_SELECTED_TEXT end, {}) }), { condition = math })

return mysnips
