local RSGCore = exports['rsg-core']:GetCoreObject()
local isBusy = false

function loadAnimDict(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

-----------------------
-- eating
-----------------------
RegisterNetEvent('rsg-consume:client:eat', function(itemName)
    if isBusy then return end
    if not IsPedOnMount(cache.ped) and not IsPedInAnyVehicle(cache.ped) then
        isBusy = true
        LocalPlayer.state:set('inv_busy', true, true)
        SetCurrentPedWeapon(cache.ped, GetHashKey('weapon_unarmed'))
        local pcoords = GetEntityCoords(cache.ped)
        itemInHand = CreateObject(Config.Consumables.Eat[itemName].propname, pcoords.x, pcoords.y, pcoords.z, true, false, false)
        AttachEntityToEntity(itemInHand, cache.ped, GetEntityBoneIndexByName(cache.ped, 'SKEL_L_Finger01'), 0.04, -0.03, -0.01, 0.0, 19.0, 46.0, true, true, false, true, 1, true)
        local dict = loadAnimDict('mech_inventory@eating@multi_bite@sphere_d8-2_sandwich')
        TaskPlayAnim(cache.ped, dict, 'quick_left_hand', 5.0, 5.0, -1, 1, false, false, false)
        Wait(5000)
        DeleteObject(itemInHand)
        ClearPedTasks(cache.ped)
        TriggerServerEvent('RSGCore:Server:SetMetaData', 'hunger', RSGCore.Functions.GetPlayerData().metadata['hunger'] + Config.Consumables.Eat[itemName].hunger)
        TriggerServerEvent('RSGCore:Server:SetMetaData', 'thirst', RSGCore.Functions.GetPlayerData().metadata['thirst'] + Config.Consumables.Eat[itemName].thirst)
        TriggerServerEvent('hud:server:RelieveStress', Config.Consumables.Eat[itemName].stress)
        TriggerServerEvent('rsg-consume:server:removeitem', Config.Consumables.Eat[itemName].item, 1)
        LocalPlayer.state:set('inv_busy', false, true)
        isBusy = false
    end
end)

-----------------------
-- drinking
-----------------------
RegisterNetEvent('rsg-consume:client:drink', function(itemName)
    if isBusy then return end
    if not IsPedOnMount(cache.ped) and not IsPedInAnyVehicle(cache.ped) then
        isBusy = true
        LocalPlayer.state:set('inv_busy', true, true)
        SetCurrentPedWeapon(cache.ped, GetHashKey('weapon_unarmed'))
        local pcoords = GetEntityCoords(cache.ped)
        itemInHand = CreateObject(Config.Consumables.Drink[itemName].propname, pcoords.x, pcoords.y, pcoords.z, true, false, false)
        AttachEntityToEntity(itemInHand, cache.ped, GetEntityBoneIndexByName(cache.ped, 'PH_R_HAND'), 0.00, 0.00, 0.04, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
        local dict = loadAnimDict('mech_inventory@drinking@bottle_cylinder_d1-3_h30-5_neck_a13_b2-5')
        TaskPlayAnim(cache.ped, dict, 'uncork', 5.0, 5.0, -1, 1, false, false, false)
        Wait(500)
        local dict = loadAnimDict('mech_inventory@drinking@bottle_cylinder_d1-3_h30-5_neck_a13_b2-5')
        TaskPlayAnim(cache.ped, dict, 'chug_a', 5.0, 5.0, -1, 1, false, false, false)
        Wait(5000)
        DeleteObject(itemInHand)
        ClearPedTasks(cache.ped)
        TriggerServerEvent('RSGCore:Server:SetMetaData', 'hunger', RSGCore.Functions.GetPlayerData().metadata['hunger'] + Config.Consumables.Drink[itemName].hunger)
        TriggerServerEvent('RSGCore:Server:SetMetaData', 'thirst', RSGCore.Functions.GetPlayerData().metadata['thirst'] + Config.Consumables.Drink[itemName].thirst)
        TriggerServerEvent('hud:server:RelieveStress', Config.Consumables.Drink[itemName].stress)
        TriggerServerEvent('rsg-consume:server:removeitem', Config.Consumables.Drink[itemName].item, 1)
        LocalPlayer.state:set('inv_busy', false, true)
        isBusy = false
    end
end)
