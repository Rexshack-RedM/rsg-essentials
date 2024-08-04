local RSGCore = exports['rsg-core']:GetCoreObject()
local isBusy = false

local WaterOutlet = {
    -40350080, -- p_waterpump01x
    -717759843, -- p_wellpumpnbx01x
}

CreateThread(function()
    if Config.canteenPump then
        exports['rsg-target']:AddTargetModel(WaterOutlet, {
            options = {
                {
                    type = "client",
                    event = 'rsg-waterpump:client:drinking',
                    icon = "far fa-eye",
                    label = Lang:t('label.take_a_drink'),
                    distance = 2.0
                },
                {
                    type = "client",
                    event = 'rsg-waterpump:client:canteenfill',
                    icon = "far fa-eye",
                    label = 'Fill up your canteen',
                    distance = 2.0
                }
            }
        })
    else
        exports['rsg-target']:AddTargetModel(WaterOutlet, {
            options = {
                {
                    type = "client",
                    event = 'rsg-waterpump:client:drinking',
                    icon = "far fa-eye",
                    label = Lang:t('label.take_a_drink'),
                    distance = 2.0
                }
            }
        })
    end
end)

RegisterNetEvent('rsg-waterpump:client:canteenfill', function()
    if Config.canteenPump then
        if RSGCore.Functions.HasItem('canteen0') then
            LocalPlayer.state:set("inv_busy", true, true)
            if lib.progressCircle({
                duration = 15000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = false,
                label = 'Filling up Your Canteen',
                TaskStartScenarioInPlace(cache.ped, joaat('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
            }) then
                TriggerServerEvent('rsg-canteen:server:givefullcanteen')
            end
            ClearPedTasks(cache.ped)
            LocalPlayer.state:set("inv_busy", false, true)
        else
            RSGCore.Functions.Notify('You do not have a canteen to fill.', 'error')
        end
    end
end)

-- waterpump drink water
RegisterNetEvent('rsg-waterpump:client:drinking', function()
    if isBusy then return end

    isBusy = true
    SetCurrentPedWeapon(cache.ped, joaat('weapon_unarmed'))
    Wait(100)
    if not IsPedOnMount(cache.ped) and not IsPedInAnyVehicle(cache.ped) then
        TaskStartScenarioInPlace(cache.ped, joaat('WORLD_HUMAN_BUCKET_DRINK_GROUND'), -1, true, false, false, false)
    end
    Wait(5000)
    TriggerServerEvent('RSGCore:Server:SetMetaData', 'thirst', RSGCore.Functions.GetPlayerData().metadata['thirst'] + math.random(25, 50))
    ClearPedTasks(cache.ped)
    isBusy = false
end)
