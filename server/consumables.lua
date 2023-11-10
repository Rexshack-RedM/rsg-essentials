local RSGCore = exports['rsg-core']:GetCoreObject()

CreateUseableItem = function()

    for k, _ in pairs(ConsumeablesDrink) do
        RSGCore.Functions.CreateUseableItem(k, function(source, item)
            local Player = RSGCore.Functions.GetPlayer(source)
            if Player.Functions.RemoveItem(k, 1, item.slot) then
                TriggerClientEvent("consumables:client:Drink", source, item.name)
            end
        end)
    end

    for k, _ in pairs(ConsumeablesEat) do

        RSGCore.Functions.CreateUseableItem(k, function(source, item)
            local Player = RSGCore.Functions.GetPlayer(source)
            if Player.Functions.RemoveItem(k, 1, item.slot) then
                if k == "stew" then
                    TriggerClientEvent("consumables:client:EatStew", source, k)
                else
                    TriggerClientEvent("consumables:client:Eat", source, k)
                end
            end
        end)
    end

end

CreateUseableItem()

-- OTHER

RSGCore.Functions.CreateUseableItem("cigarette", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Smoke", source, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("cigar", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Smoke", source, item.name)
    end
end)

RSGCore.Functions.CreateUseableItem("binoculars", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("binoculars:Toggle", source)
end)

RSGCore.Functions.CreateUseableItem("dual", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent("qb:Dual", source)
end)

-- player field bandage
RSGCore.Functions.CreateUseableItem("fieldbandage", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    TriggerClientEvent('consumables:client:UseFieldBandage', source)
end)

-- remove item
RegisterNetEvent('consumables:server:removeitem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
    TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item], "remove")
end)
