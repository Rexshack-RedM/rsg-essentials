local isBusy = false
local QRCore = exports['qr-core']:GetCoreObject()

function loadAnimDict(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

function loadModel(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

function doAnim (Amodel, bone, pX, pY, pZ, rX, rY, rZ, anim, Adict, duration)
    local model = loadModel(GetHashKey(Amodel))
    object = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
    AttachEntityToEntity(object, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), bone), pX, pY, pZ, rX, rY, rZ, false, true, true, true, 0, true)
    local dict = loadAnimDict(Adict)
    TaskPlayAnim(PlayerPedId(), dict, anim, 5.0, 5.0, duration, 1, false, false, false)
end

function AnimDetatch (sleep)
    Citizen.Wait(sleep)
    if object ~= nil then
        DetachEntity(object, true, true)
        DeleteObject(object)
    end
end

RegisterNetEvent("consumables:client:Drink", function(itemName)
    if isBusy then
        return
    else
        isBusy = not isBusy
        local sleep = 5000
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"))
        Citizen.Wait(100)
        if not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) then
            local object = nil
            doAnim("p_mugcoffee01x", "SKEL_R_FINGER12", 0.0, -0.05, 0.03, 0.0, 180.0, 180.0, 'action', 'mech_inventory@drinking@coffee', sleep)
        end
		Wait(sleep)
		TriggerEvent("inventory:client:ItemBox", QRCore.Shared.Items[itemName], "remove")
		TriggerServerEvent("QRCore:Server:SetMetaData", "thirst", QRCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeablesDrink[itemName])
        ClearPedTasks(PlayerPedId())
        AnimDetatch (sleep)
        isBusy = not isBusy
    end
end)

RegisterNetEvent("consumables:client:Smoke", function(itemName)
    if isBusy then
        return
    else
        isBusy = not isBusy
        local sleep = 10000
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"))
        Citizen.Wait(100)
        local cigar = nil
        if not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) then
            local item_model = nil
            local pX, pY, pZ, rX, rY, rZ = nil, nil, nil, nil, nil, nil
            if itemName == "cigar" then
                sleep = 20000
                item_model = "p_cigar01x"
                pX, pY, pZ, rX, rY, rZ = 0.0, 0.03, 0.0, 0.0, 00.0, 0.0
            else
                item_model = "p_cigarette_cs01x"
                pX, pY, pZ, rX, rY, rZ = 0.0, 0.03, 0.01, 0.0, 180.0, 90.0
            end
            doAnim(item_model, "SKEL_R_FINGER12", pX, pY, pZ, rX, rY, rZ, 'base', 'amb_wander@code_human_smoking_wander@cigar@male_a@base', sleep)
        end
		Wait(sleep)
		TriggerEvent("inventory:client:ItemBox", QRCore.Shared.Items[itemName], "remove")
		TriggerServerEvent('hud:server:RelieveStress', math.random(20, 40))
        ClearPedTasks(PlayerPedId())
        AnimDetatch (sleep)
        isBusy = not isBusy
    end
end)

RegisterNetEvent("consumables:client:DrinkAlcohol", function(itemName)
    if isBusy then
        return
    else
        isBusy = not isBusy
        sleep = 5000
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"))
        Citizen.Wait(100)
        local bottle = nil
        if not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) then
            doAnim("s_inv_whiskey01x", "SKEL_R_FINGER12", 0.0, -0.05, 0.22, 0.0, 180.0, 180.0, 'base_trans_cheers_putaway', 'mp_mech_inventory@drinking@moonshine@drunk@male_a', sleep)
        end
		Wait(sleep)
		TriggerEvent("inventory:client:ItemBox", QRCore.Shared.Items[itemName], "remove")
		TriggerServerEvent("QRCore:Server:RemoveItem", itemName, 1)
		TriggerServerEvent("QRCore:Server:SetMetaData", "thirst", QRCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeablesAlcohol[itemName])
        Citizen.Wait(sleep)
        if bottle ~= nil then
            DetachEntity(bottle, true, true)
            DeleteObject(bottle)
        end
        ClearPedTasks(PlayerPedId())
        AnimDetatch (sleep)
        isBusy = not isBusy
    end
end)

RegisterNetEvent("consumables:client:Eat", function(itemName)
    if isBusy then
        return
    else
        isBusy = not isBusy
		sleep = 5000
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"))
        Citizen.Wait(100)
        if not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) then
            local dict = loadAnimDict('mech_inventory@eating@multi_bite@wedge_a4-2_b0-75_w8_h9-4_eat_cheese')
            TaskPlayAnim(PlayerPedId(), dict, 'quick_right_hand', 5.0, 5.0, -1, 1, false, false, false)
        end
		Wait(sleep)
		TriggerEvent("inventory:client:ItemBox", QRCore.Shared.Items[itemName], "remove")
		TriggerServerEvent("QRCore:Server:SetMetaData", "hunger", QRCore.Functions.GetPlayerData().metadata["hunger"] + ConsumeablesEat[itemName])
		TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
        ClearPedTasks(PlayerPedId())
        isBusy = not isBusy
    end
end)

RegisterNetEvent("qb:Dual", function()
    local player = PlayerPedId()
	Citizen.InvokeNative(0xB282DC6EBD803C75, player, GetHashKey("weapon_revolver_cattleman"), 500, true, 0)
	Citizen.InvokeNative(0x5E3BDDBCB83F3D84, player, GetHashKey("weapon_pistol_volcanic"), 500, true, 0, true, 1.0)
end)
