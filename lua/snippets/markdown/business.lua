local mysnips = {}

mysnips[#mysnips+1] = s({ trig="order" }, fmta([[
### Subject: Query related to <>

Dear <>,

<>

Warm regards,

<>
]], { i(1), i(2), i(3), i(4) })
)

mysnips[#mysnips+1] = s({ trig="inquiry" }, fmta([[
### Subject: Query related to <>

Dear <>,

<>

Warm regards,

<>
]], { i(1), i(2), i(3), i(4) })
)

mysnips[#mysnips+1] = s({ trig="complaint" }, {
	t("ligmatron")

})
mysnips[#mysnips+1] = s({ trig="offer" }, {
	t("ligmatron")
})
mysnips[#mysnips+1] = s({ trig="meeting" }, {
	t("ligmatron")
})

return mysnips
