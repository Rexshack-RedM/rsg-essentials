local RSGCore = exports['rsg-core']:GetCoreObject()

-----------------------
-- eat
-----------------------
for k, _ in pairs(Config.Consumables.Eat) do
    RSGCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerClientEvent('rsg-consume:client:eat', source, item.name)
    end)
end

-----------------------
-- drink
-----------------------
for k, _ in pairs(Config.Consumables.Drink) do
    RSGCore.Functions.CreateUseableItem(k, function(source, item)
        TriggerClientEvent('rsg-consume:client:drink', source, item.name)
    end)
end

---------------------------------------------
-- remove item
---------------------------------------------
RegisterServerEvent('rsg-consume:server:removeitem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem(item, amount)
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[item], 'remove', amount)
end)
