local Menu = require("menu")
local Cart = require("cart")
local Order = require("order")
local Display = require("display")

local function main()
    local menu = Menu
    local cart = Cart
    local order = Order
    Display.userInterface(menu, cart, order)
end

main()
