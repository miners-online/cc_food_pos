local Menu = {}

function Menu.loadMenus()
    local menus = {}
    local files = fs.list("menus")
    for _, file in ipairs(files) do
        if file:match("%.json$") then
            local filePath = fs.combine("menus", file)
            local fileHandle = fs.open(filePath, "r")
            local content = fileHandle.readAll()
            fileHandle.close()
            local menuType = file:gsub("%.json$", "")
            menus[menuType] = textutils.unserializeJSON(content)
        end
    end
    return menus
end

Menu.menus = Menu.loadMenus()

function Menu:getMenu(type)
    return self.menus[type] or {}
end

return Menu
