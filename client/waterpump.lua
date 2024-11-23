local RSGCore = exports['rsg-core']:GetCoreObject()
local isBusy = false
lib.locale()

local WaterOutlet = {
    -40350080, -- p_waterpump01x
    -717759843, -- p_wellpumpnbx01x
}

CreateThread(function()
    if Config.canteenPump then
        exports.ox_target:addModel(WaterOutlet, {
            {
                name = 'waterpump_main_canteenfill',
                event = 'rsg-waterpump:client:canteenfill',
                icon = 'far fa-eye',
                label = locale('cl_canteen_take_a'),
                canInteract = function(_, distance)
                    return distance < 3.0
                end
            },
            {
                name = 'waterpump_main_drinking',
                event = 'rsg-waterpump:client:drinking',
                icon = 'far fa-eye',
                label = locale('cl_canteen_take_b'),
                canInteract = function(_, distance)
                    return distance < 3.0
                end
            }
        })
    else
        exports.ox_target:addModel(WaterOutlet, {
            {
                name = 'waterpump_main_drinking_c',
                event = 'rsg-waterpump:client:drinking',
                icon = 'far fa-eye',
                label = locale('cl_canteen_take_b'),
                canInteract = function(_, distance)
                    return distance < 3.0
                end
            }
        })
    end
end)

RegisterNetEvent('rsg-waterpump:client:canteenfill', function()
    if Config.canteenPump then
        if RSGCore.Functions.HasItem('canteen0') then
            LocalPlayer.state:set('inv_busy', true, true)
            if lib.progressBar({
                duration = 15000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = false,
                disableControl = true,
                disable = { move = true, mouse = true },
                anim = { scenario = 'WORLD_HUMAN_CROUCH_INSPECT' },
                label = locale('cl_canteen_take_c'),
            }) then
                TriggerServerEvent('rsg-canteen:server:givefullcanteen')
            end
            LocalPlayer.state:set('inv_busy', false, true)
        else
            lib.notify({ title = locale('cl_canteen_take_d'), description = locale('cl_canteen_take_e'), type = 'error', duration = 7000 })
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