local Cart = {}
Cart.items = {}

function Cart:addItem(menu, menuType, itemId, quantity)
    local item = menu:getMenu(menuType)[itemId]
    if item then
        table.insert(self.items, {item = item, quantity = quantity})
    end
end

function Cart:removeItem(index)
    table.remove(self.items, index)
end

function Cart:modifyItem(index, newQuantity)
    if self.items[index] then
        self.items[index].quantity = newQuantity
    end
end

function Cart:getItems()
    return self.items
end

function Cart:clear()
    self.items = {}
end

return Cart
