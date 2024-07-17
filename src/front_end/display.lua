local Display = {}

function Display.showMenu(menu, menuType)
    local menuItems = menu:getMenu(menuType)
    for _, item in ipairs(menuItems) do
        print(item.id .. ". " .. item.name .. " - $" .. string.format("%.2f", item.price))
    end
end

function Display.showCart(cart)
    local items = cart:getItems()
    for index, cartItem in ipairs(items) do
        print(index .. ". " .. cartItem.item.name .. " x" .. cartItem.quantity .. " - $" .. string.format("%.2f", cartItem.item.price * cartItem.quantity))
    end
end

function Display.userInterface(menu, cart, order)
    while true do
        print("Available menu types: ")
        for menuType, _ in pairs(menu.menus) do
            print(menuType)
        end
        print("Select menu type: ")
        local menuType = io.read()

        if menu.menus[menuType] then
            Display.showMenu(menu, menuType)

            while true do
                print("Select an item to add to cart (item number) or type 'done' to finish:")
                local selection = io.read()
                if selection == "done" then
                    Display.showCart(cart)
                    print("Complete the order? (yes/no)")
                    local complete = io.read()
                    if complete == "yes" then
                        order.completeOrder(cart)
                        print("Start a new order? (yes/no)")
                        local newOrder = io.read()
                        if newOrder == "yes" then
                            order.startAgain(cart)
                        else
                            return
                        end
                    else
                        print("Order cancelled.")
                        return
                    end
                else
                    local itemId = tonumber(selection)
                    print("Enter quantity:")
                    local quantity = tonumber(io.read())
                    cart:addItem(menu, menuType, itemId, quantity)
                end
            end
        else
            print("Invalid selection")
        end
    end
end

return Display
