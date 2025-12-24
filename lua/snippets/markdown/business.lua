local mysnips = {}
local extras = require("luasnip.extras")


local product_list = {
	"Bearings",
	"Cuffs",
	"Wheels",
	"Liners",
	"Frames",
	"Laces",
	"Buckles",
	"Straps",
	"Soleplates",
}

local parsed_product_list = {}

for _, value in pairs(product_list) do
	parsed_product_list[#parsed_product_list+1] = t(value)
end

mysnips[#mysnips+1] = s({ trig="order" }, fmta([[
### Subject: Order for <> (<>)

Dear <>,

I'm placing an order <>

### Item details

<>

### Delivery requirements

<>

Warm regards,

<>
]], { c(1, parsed_product_list ), i(2, "PO Number"), i(3, "John Doe"), i(4), i(5), i(6), c(7, { t("Robert Hayrapetyan"), t("Marina Aghababyan") } ) })
)


mysnips[#mysnips+1] = s({ trig="inquiry" }, fmta([[
### Subject: Query related to <>. Request for information.

Dear <>,

<>

### Queries


Warm regards,

<>
]], { i(1), i(2), i(3), c(4, { t("Robert Hayrapetyan"), t("Marina Aghababyan") }) })
)

mysnips[#mysnips+1] = s({ trig="complaint" }, fmta([[
### Subject: Issues with <> (<>)

Dear <>,

<>

### Queries


Warm regards,

<>
]], { i(1, "DESCRIBE ISSUE") , i(2, "PO Number"), i(3), i(4), c(5, { t("Robert Hayrapetyan"), t("Marina Aghababyan") })  })
)

mysnips[#mysnips+1] = s({ trig="offer" }, fmta([[
### Subject: <> for <>

Dear <>,

<>

Below are listed relevant links.

### Links


Warm regards,

<>
]], { i(1, "BENEFIT") , i(2, "COMPANY NAME"), i(3), i(4), c(5, { t("Robert Hayrapetyan"), t("Marina Aghababyan") })  })
)

mysnips[#mysnips+1] = s({ trig="meeting" }, fmta([[
### Meeting request: <> on <> at <>

Dear <>,

<>

Below are listed relevant links.

### Links


Warm regards,

<>
]], { i(1, "TOPIC") , i(2, os.date("%h %d %Y")), i(3, os.date("%H:%M") ), i(4), i(5), c(6, { t("Robert Hayrapetyan"), t("Marina Aghababyan") })  })
)

--- Wording

mysnips[#mysnips+1] = s({ trig="h-opening" }, fmta([[<>]], { c(1, {
	t("I hope you are doing well"),
	t("I hope this email finds you well"),
	t("I trust you had a great weekend"),
	t("I hope you have a productive week"),
}) })
)

mysnips[#mysnips+1] = s({ trig="h-purpose" }, fmta([[<>]], { c(1, {
	t("I'm reaching out to"),
	t("I'm writing to"),
	t("I would like to discuss"),
	t("I wanted to check in on"),
}) })
)

mysnips[#mysnips+1] = s({ trig="h-requests" }, fmta([[<>]], { c(1, {
	t("Could you please provide me with"),
	t("Would it be possible to"),
	t("I'd appreciate it if you could"),
	t("Could you kindly confirm"),
}) })
)

mysnips[#mysnips+1] = s({ trig="h-proposals" }, fmta([[<>]], { c(1, {
	t("Could you please provide me with"),
	t("Would it be possible to"),
	t("I'd appreciate it if you could"),
	t("Could you kindly confirm"),
}) })
)

mysnips[#mysnips+1] = s({ trig="h-closing" }, fmta([[<>]], { c(1, {
	t("Looking forward to your reply"),
	t("I look forward to hearing from you soon"),
	t("Please feel free to reach out if you need anything else"),
}) })
)

mysnips[#mysnips+1] = s({ trig="h-initials" }, fmta([[<>]], { c(1, {
	t("Sincerely"),
	t("Yours faithfully"),
	t("Kind regards"),
}) })
)

-- Auxillary

mysnips[#mysnips+1] = s({ trig="bullet" }, fmta([[
- <>
- <>
- <>
]], { i(1, "Item #1"), i(2, "Item #2"), i(3, "Item #3"), })
)

mysnips[#mysnips+1] = s({ trig="table" }, fmta([[
| Item  | Description | Cost |
|-------|-------------|------|
| <> |
| <> |
| <> |
]], { i(1, "Item #1"), i(2, "Item #2"), i(3, "Item #3"), })
)



return mysnips
