local RSGCore = exports['rsg-core']:GetCoreObject()

local isBusy = false
local testAnimDict = 'amb_rest_drunk@world_human_drinking@flask@male_a@stand_enter'
local testAnim = 'enter_back_lf'

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

AddEventHandler('rsg-essentials:client:DrinkingAnimation', function()
    local ped = PlayerPedId()

    loadAnimDict(testAnimDict)

    Wait(100)

    TaskPlayAnim(ped, testAnimDict, testAnim, 3.0, 3.0, -1, 1, 0, false, false, false)
end)

RegisterNetEvent("consumables:client:Drink", function(itemName)
    if isBusy then
        return
    else
        isBusy = not isBusy
        sleep = 5000
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"))
        Citizen.Wait(100)
        if not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) then
            doAnim("p_mugcoffee01x", "SKEL_R_FINGER12", 0.0, -0.05, 0.03, 0.0, 180.0, 180.0, 'action', 'mech_inventory@drinking@coffee', sleep)
            TaskPlayAnim(PlayerPedId(), dict, 'idle_a', 5.0, 5.0, -1, 1, false, false, false)
        end
        Wait(sleep)
        TriggerEvent("inventory:client:ItemBox", RSGCore.Shared.Items[itemName], "remove")
        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeablesDrink[itemName])
        lib.notify({ title = 'Success', description = 'You had a drink!', type = 'success', duration = 5000 })
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
        local sleep = 5000
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"))
        Citizen.Wait(100)
        local cigar = nil
        if not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) then
            local item_model = nil
            local pX, pY, pZ, rX, rY, rZ = nil, nil, nil, nil, nil, nil
            if itemName == "cigar" then
                sleep = 30000
                item_model = "p_cigar01x"
                pX, pY, pZ, rX, rY, rZ = 0.0, 0.03, 0.0, 0.0, 00.0, 0.0
            else
                item_model = "p_cigarette_cs01x"
                pX, pY, pZ, rX, rY, rZ = 0.0, 0.03, 0.01, 0.0, 180.0, 90.0
            end
            doAnim(item_model, "SKEL_R_FINGER12", pX, pY, pZ, rX, rY, rZ, 'idle_a', 'amb_rest@world_human_smoking@male_a@idle_a', sleep)
        end
        Wait(sleep)
        TriggerEvent("inventory:client:ItemBox", RSGCore.Shared.Items[itemName], "remove")
        TriggerServerEvent('hud:server:RelieveStress', math.random(30, 50))
        lib.notify({ title = 'Success', description = 'You had a smoke!', type = 'success', duration = 5000 })
        ClearPedTasks(PlayerPedId())
        AnimDetatch (sleep)
        isBusy = not isBusy
    end
end)

RegisterNetEvent("consumables:client:SmokeCicarette", function(itemName)
    if isBusy then
        return
    else
        isBusy = not isBusy
        local sleep = 5000
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"))
        Citizen.Wait(100)
        local cigar = nil
        if not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) then
            local item_model = nil
            local pX, pY, pZ, rX, rY, rZ = nil, nil, nil, nil, nil, nil
            if itemName == "cigarette" then
                sleep = 30000
                item_model = "P_CIGARETTE01X"
                pX, pY, pZ, rX, rY, rZ = 0.0, 0.03, 0.01, 0.0, 180.0, 90.0
            else
                item_model = "p_cigarette_cs01x"
                pX, pY, pZ, rX, rY, rZ = 0.0, 0.03, 0.0, 0.0, 00.0, 0.0
            end
            doAnim(item_model, "SKEL_R_FINGER12", pX, pY, pZ, rX, rY, rZ, 'idle_a', 'amb_rest@world_human_smoking@male_a@idle_a', sleep)
        end
        Wait(sleep)
        TriggerEvent("inventory:client:ItemBox", RSGCore.Shared.Items[itemName], "remove")
        TriggerServerEvent('hud:server:RelieveStress', math.random(20, 40))
        lib.notify({ title = 'Success', description = 'You had a smoke!', type = 'success', duration = 5000 })
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
        TriggerEvent("inventory:client:ItemBox", RSGCore.Shared.Items[itemName], "remove")
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] + ConsumeablesEat[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
        ClearPedTasks(PlayerPedId())
        isBusy = not isBusy
    end
end)

RegisterNetEvent("consumables:client:EatStew", function(itemName)
    if isBusy then
        return
    else
        isBusy = not isBusy
        sleep = 5000
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"))
        local bowl = CreateObject("p_bowl04x_stew", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
        local spoon = CreateObject("p_spoon01x", GetEntityCoords(PlayerPedId()), true, true, false, false, true)
        Citizen.InvokeNative(0x669655FFB29EF1A9, bowl, 0, "Stew_Fill", 1.0)
        Citizen.InvokeNative(0xCAAF2BCCFEF37F77, bowl, 20)
        Citizen.InvokeNative(0xCAAF2BCCFEF37F77, spoon, 82)
        TaskItemInteraction_2(PlayerPedId(), 599184882, bowl, GetHashKey("p_bowl04x_stew_ph_l_hand"), -583731576, 1, 0, -1.0)
        TaskItemInteraction_2(PlayerPedId(), 599184882, spoon, GetHashKey("p_spoon01x_ph_r_hand"), -583731576, 1, 0, -1.0)
        Citizen.InvokeNative(0xB35370D5353995CB, PlayerPedId(), -583731576, 1.0)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] + ConsumeablesEat[itemName])
        isBusy = not isBusy
    end
end)

-- player use bandage
RegisterNetEvent('consumables:client:UseFieldBandage', function()
    local ped = PlayerPedId()
    local hasItem = RSGCore.Functions.HasItem('fieldbandage', 1)
    if hasItem then
        RSGCore.Functions.Progressbar("use_fieldbandage", "Using Field Bandage..", 4000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "mini_games@story@mob4@heal_jules@bandage@arthur",
            anim = "bandage_fast",
            flags = 1,
        }, {}, {}, function() -- Done
            StopAnimTask(ped, "mini_games@story@mob4@heal_jules@bandage@arthur", "bandage_fast", 1.0)
            TriggerServerEvent('consumables:server:removeitem', 'fieldbandage', 1)
            SetEntityHealth(ped, GetEntityHealth(ped) + 10)
        end, function() -- Cancel
            StopAnimTask(ped, "mini_games@story@mob4@heal_jules@bandage@arthur", "bandage_fast", 1.0)
            lib.notify({ title = 'Error', description = Lang:t('error.canceled'), type = 'error', duration = 5000 })
        end)
    else
        lib.notify({ title = 'Error', 'you don\'t have any field bandages!', type = 'error', duration = 5000 })
    end
end)
