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

})

ls.add_snippets("tex", {
	s({ trig="mk", snippetType="autosnippet" }, {
		t"$", i(1), t"$", i(2)
	}),
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

local mysnippets = {}

for index = 1, #list, 1 do
	mysnippets[#mysnippets+1] = s({ trig="^(>*)"..list[index][1], regTrig = true, snippetType="autosnippet" }, {
		f(function(args, snip) return
			snip.captures[1]..list[index][3] end, {}),
	})
	mysnippets[#mysnippets+1] = s({ trig="^(>*)"..list[index][2], regTrig = true, snippetType="autosnippet" }, {
		f(function(args, snip) return
			snip.captures[1]..list[index][3] end, {}),
	})
end

local characters = { ">", "-", "=" }

for index = 1, #characters, 1 do
	mysnippets[#mysnippets+1] = s({ trig=characters[index].."Ю", snippetType="autosnippet" }, {
		t(characters[index]..">")
	})
end

ls.add_snippets("markdown", mysnippets)


ls.add_snippets("markdown", {
	s({ trig="^(>*)mu;", regTrig = true, snippetType="autosnippet" }, {
		f(function(args, snip) return
			snip.captures[1]..">[!multi-column]" end, {}),
		t({"", ""}),
		f(function(args, snip) return
			snip.captures[1]..">>" end, {}),
	}),
	s({ trig="^(>*)ьгж", regTrig = true, snippetType="autosnippet" }, {
		f(function(args, snip) return
			snip.captures[1]..">[!multi-column]" end, {}),
		t({"", ""}),
		f(function(args, snip) return
			snip.captures[1]..">>" end, {}),
	}),

	s({ trig="^(>*)lo;", regTrig = true, snippetType="autosnippet" }, {
		f(function(args, snip) return
			snip.captures[1]..">[!look]" end, {}),
		t({"", ""}),
		f(function(args, snip) return
			snip.captures[1]..">" end, {}),
	}),
	s({ trig="^(>*)дщж", regTrig = true, snippetType="autosnippet" }, {
		f(function(args, snip) return
			snip.captures[1]..">[!look]" end, {}),
		t({"", ""}),
		f(function(args, snip) return
			snip.captures[1]..">" end, {}),
	}),

	s({ trig="Ъ", snippetType="autosnippet" }, {
		t("|")
	}),
	s({ trig="^Ю", regTrig = true, snippetType="autosnippet" }, {
		t(">")
	}),
	s({ trig="^:", regTrig = true, snippetType="autosnippet" }, {
		t("^")
	}),

	s({ trig="(%[%[.*)№", regTrig = true, snippetType="autosnippet" }, {
	f(function(args, snip) return
		snip.captures[1].."#" end, {})
	}),
	s({ trig="#:", snippetType="autosnippet" }, {
		t("#^")
	}),
	s({ trig="№:", snippetType="autosnippet" }, {
		t("#^")
	}),
})
