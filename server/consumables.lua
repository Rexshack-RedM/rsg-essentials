-- local RSGCore = exports['rsg-core']:GetCoreObject()
-- local CreateUseableItem = function()
--     -- Obtención de la lista de alimentos referenciados en el archivo de configuración.
--     for k, _ in pairs(ConsumeablesEatStew) do
--         -- Creación de alimentos
--         RSGCore.Functions.CreateUseableItem(k, function(source, item)
--             local Player = RSGCore.Functions.GetPlayer(source)
--             if Player.Functions.RemoveItem(k, 1, item.slot) then
--                 TriggerClientEvent("consumables:client:EatStew", source, k)
--                 TriggerClientEvent('rsg-inventory:client:ItemBox', RSGCore.Shared.Items[k], 'remove')
--             end
--         end)
--     end
-- end

-- CreateUseableItem()

-- OTHER

-- RSGCore.Functions.CreateUseableItem("binoculars", function(source, item)
--     local Player = RSGCore.Functions.GetPlayer(source)
--     TriggerClientEvent("binoculars:Toggle", source)
-- end)

-- RSGCore.Functions.CreateUseableItem("dual", function(source, item)
--     local Player = RSGCore.Functions.GetPlayer(source)
--     TriggerClientEvent("qb:Dual", source)
-- end)

-- -- player field bandage
-- RSGCore.Functions.CreateUseableItem("fieldbandage", function(source, item)
--     local Player = RSGCore.Functions.GetPlayer(source)
--     TriggerClientEvent('consumables:client:UseFieldBandage', source)
-- end)

-- -- remove item
-- RegisterNetEvent('consumables:server:removeitem', function(item, amount)
--     local src = source
--     local Player = RSGCore.Functions.GetPlayer(src)
--     Player.Functions.RemoveItem(item, amount)
--     TriggerClientEvent("rsg-inventory:client:ItemBox", src, RSGCore.Shared.Items[item], "remove")
-- end)
