local RSGCore = exports['rsg-core']:GetCoreObject()

CreateUseableItem = function()
    -- Obtention de la liste des boissons référencés dans le fichier de configuration.
    for k, _ in pairs(ConsumeablesDrink) do
        -- Création de la nouriture
        RSGCore.Functions.CreateUseableItem(k, function(source, item)
            local Player = RSGCore.Functions.GetPlayer(source)
            if Player.Functions.RemoveItem(k, 1, item.slot) then
                TriggerClientEvent("consumables:client:Drink", source, item.name)
            end
        end)
    end
    -- Obtention de la liste de nouriture référencés dans le fichier de configuration.
    for k, _ in pairs(ConsumeablesEat) do
        -- Création de la nouriture
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

--| Création des items au lancement du script.
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
