local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

ls.add_snippets("lua", {
	s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1)})),

	s({ trig="mk", snippetType="autosnippet" }, {
		t"$", i(1), t"$", i(2)
	}),
})

ls.add_snippets("tex", {
})

local list = {
	{ "de;", "вуж", ">[!definition] " },
	{ "ru;", "кгж", ">[!rule] " },
	{ "al;", "фдж", ">[!algorithm] " },
	{ "th;", "ерж", ">[!theorem] " },
	{ "le;", "дуж", ">[!lemma] " },
	{ "la;", "дфж", ">[!law] " },
	{ "ad;", "фвж", ">[!add] " },
	{ "ex;", "учж", ">[!example] " },
	{ "gr;", "пкж", ">[!graveyard] " },
	{ "fo;", "ащж", ">[!formula] " },
	{ "wa;", "цфж", ">[!warning] " },
	{ "ti;", "ешж", ">[!tip] " },
	{ "bl;", "идж", ">[!blank-container]" },
	{ "im;", "шьж", ">[!important] " },
}

local keybinds = {}

for index = 1, #list, 1 do
	keybinds[#keybinds+1] = s({ trig=list[index][1], snippetType="autosnippet" }, {
		t(list[index][3])
	})
	keybinds[#keybinds+1] = s({ trig=list[index][2], snippetType="autosnippet" }, {
		t(list[index][3])
	})
end

local characters = { ">", "-", "=" }

for index = 1, #characters, 1 do
	keybinds[#keybinds+1] = s({ trig=characters[index].."Ю", snippetType="autosnippet" }, {
		t(characters[index]..">")
	})
end

ls.add_snippets("markdown", keybinds)


ls.add_snippets("markdown", {
	s({ trig="mu;", snippetType="autosnippet" }, {
		t({ ">[!multi-column]",">>" })
	}),
	s({ trig="ьгж", snippetType="autosnippet" }, {
		t({ ">[!multi-column]",">>" })
	}),

	s({ trig="lo;", snippetType="autosnippet" }, {
		t({ ">[!look]",">" })
	}),
	s({ trig="дщж", snippetType="autosnippet" }, {
		t({ ">[!look]",">" })
	}),

	s({ trig="Ъ", snippetType="autosnippet" }, {
		t("|")
	}),
	s({ trig="^Ю", trigEngine = "ecma", snippetType="autosnippet" }, {
		t(">")
	}),
	s({ trig="(\\[\\[.*)№", trigengine = "ecma", snippetType="autosnippet" }, {
	f(function(args, snip) return
		snip.captures[1].."#" end, {})
	}),
	s({ trig="#:", snippetType="autosnippet" }, {
		t("#^")
	}),
})
