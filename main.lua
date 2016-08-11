
local kk = require("./kk");

local io = require("io");

local fd = io.open("./app/index.lhtml","r");

local page = {title = 'title' };

print(kk.page(page,fd:read("*a")));

fd:close();
