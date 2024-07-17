local Order = {}
local orderNumber = 0

function Order.completeOrder(cart)
    orderNumber = orderNumber + 1
    print("Order Completed. Processing payment...")
    Order.printReceipt(cart)
end

function Order.printReceipt(cart)
    local printer = peripheral.wrap("left")
    local oldTerm = term.redirect(printer)

    printer.isColour = function ()
        return false
    end

    printer.isColor = printer.isColour
    printer.getSize = printer.getPageSize

    printer.newPage()
    print("Order #" .. orderNumber)
    print("----")

    local items = cart:getItems()
    for _, cartItem in ipairs(items) do
        print(cartItem.item.name .. " x" .. cartItem.quantity .. " - $" .. string.format("%.2f", cartItem.item.price * cartItem.quantity))
    end

    local total = 0
    for _, cartItem in ipairs(items) do
        total = total + (cartItem.item.price * cartItem.quantity)
    end
    print("----")
    print("Total: $" .. string.format("%.2f", total))
    printer.endPage()
    term.redirect(oldTerm)

    sleep(1)
    local chest_a = peripheral.wrap("bottom")
    local chest_b = peripheral.wrap("back")
    chest_a.pushItems(peripheral.getName(chest_b), 1)
    sleep(0.5)
    redstone.setOutput("back", true)
    sleep(0.5)
    redstone.setOutput("back", false)
end

function Order.startAgain(cart)
    cart:clear()
    print("New order started.")
end

return Order
