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

local mysnips = {}

for index = 1, #list, 1 do
	mysnips[#mysnips+1] = ms({ common = { regTrig = true, snippetType="autosnippet" }, "^(>*)"..list[index][1], "^(>*)"..list[index][2] }, {
		f(function(args, snip) return
			snip.captures[1]..list[index][3] end, {}),
	})
end

for _, characters in ipairs({ ">", "-", "=" }) do
	mysnips[#mysnips+1] = s({ trig=characters.."Ю", snippetType="autosnippet" }, {
		t(characters..">")
	})
end

return mysnips
