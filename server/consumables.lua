local QRCore = exports['qr-core']:GetCoreObject()

-- Drink

QRCore.Functions.CreateUseableItem("water", function(source, item)
    local Player = QRCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Drink", source, item.name)
    end
end)

QRCore.Functions.CreateUseableItem("coffee", function(source, item)
    local Player = QRCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Drink", source, item.name)
    end
end)

-- DrinkAlcohol

QRCore.Functions.CreateUseableItem("vodka", function(source, item)
    local Player = QRCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name)
end)

QRCore.Functions.CreateUseableItem("beer", function(source, item)
    local Player = QRCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name)
end)

QRCore.Functions.CreateUseableItem("whiskey", function(source, item)
    local Player = QRCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name)
end)

-- EAT

QRCore.Functions.CreateUseableItem("sandwich", function(source, item)
    local Player = QRCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QRCore.Functions.CreateUseableItem("bread", function(source, item)
    local Player = QRCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QRCore.Functions.CreateUseableItem("apple", function(source, item)
    local Player = QRCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QRCore.Functions.CreateUseableItem("chocolate", function(source, item)
    local Player = QRCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

-- OTHER

QRCore.Functions.CreateUseableItem("cigarette", function(source, item)
    local Player = QRCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Smoke", source, item.name)
    end
end)

QRCore.Functions.CreateUseableItem("cigar", function(source, item)
    local Player = QRCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Smoke", source, item.name)
    end
end)

QRCore.Functions.CreateUseableItem("binoculars", function(source, item)
    local Player = QRCore.Functions.GetPlayer(source)
    TriggerClientEvent("binoculars:Toggle", source)
end)

QRCore.Functions.CreateUseableItem("dual", function(source, item)
    local Player = QRCore.Functions.GetPlayer(source)
    TriggerClientEvent("qb:Dual", source)
end)