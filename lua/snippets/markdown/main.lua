return {
	ms({ common = { regTrig=true, snippetType="autosnippet" }, "^(>*)mu;", "^(>*)ьгж" }, {
		f(function(args, snip) return snip.captures[1]..">[!multi-column]" end, {}),
		t({"", ""}),
		f(function(args, snip) return snip.captures[1]..">>" end, {}),
	}),

	ms({ common = { regTrig=true, snippetType="autosnippet" },"^(>*)lo;", "^(>*)дщж" }, {
		f(function(args, snip) return snip.captures[1]..">[!look]" end, {}),
		t({"", ""}),
		f(function(args, snip) return snip.captures[1]..">" end, {}),
	}),

	s({ trig="Ъ", snippetType="autosnippet" }, {
		t("|")
	}),
	s({ trig="^Ю", regTrig=true, snippetType="autosnippet" }, {
		t(">")
	}),
	s({ trig="^:", regTrig=true, snippetType="autosnippet" }, {
		t("^")
	}),

	s({ trig="(%[%[.*)№", regTrig=true, snippetType="autosnippet" }, {
		f(function(args, snip) return snip.captures[1].."#" end, {})
	}),
	s({ trig="#:", wordTrig=false, snippetType="autosnippet" }, {
		t("#^")
	}),
	s({ trig="№:", wordTrig=false, snippetType="autosnippet" }, {
		t("#^")
	}),
}
