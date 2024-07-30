local RSGCore = exports['rsg-core']:GetCoreObject()
local PauseOpen = false

-- ped drown / boat sink fix
CreateThread(function()
    while true do
        Wait(0)
        SetPedResetFlag(cache.ped, 364)
    end
end)

-- change voice proximity
CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(0, RSGCore.Shared.Keybinds['RIGHTBRACKET']) then
            ExecuteCommand('cycleproximity')
        end
    end
end)

-- wagon stuck fix
CreateThread(function()
    local vehiclePool = {}
    local wagon = 0
    local driver = 0
    local horse = 0
    while true do
        vehiclePool = GetGamePool('CVehicle')
        for i = 1, #vehiclePool do
            wagon = vehiclePool[i]
            -- is wagon stopped
            if IsEntityAVehicle(wagon) and IsVehicleStopped(wagon) then
                -- get the horse
                horse = GetPedInDraftHarness(wagon, 0)
                -- if vehicle stopped but the horse walks = buggy wagon
                if IsPedWalking(horse) then
                    -- delete driver & wagon
                    driver = GetDriverOfVehicle(wagon)
                    if driver ~= cache.ped then
                        if driver then
                            DeleteEntity(driver)
                        end
                        DeleteEntity(wagon)
                    end
                end
            end
        end
        Wait(1000)
    end
end)

-- pause menu animation
CreateThread(function()
    while true do
        Wait(0)

        if IsPauseMenuActive() and not PauseOpen and Config.PauseReadBook then
            SetCurrentPedWeapon(cache.ped, 0xA2719263, true) -- set unarmed
            SetCurrentPedWeapon(cache.ped, joaat('weapon_unarmed'))
            if not IsPedOnMount(cache.ped) then
                TaskStartScenarioInPlace(cache.ped, joaat('WORLD_HUMAN_SIT_GROUND_READING_BOOK'), -1, true, "StartScenario", 0, false)
            end
            PauseOpen = true
        end

        if not IsPauseMenuActive() and PauseOpen then
            ClearPedTasks(cache.ped)
            Wait(4000)
            SetCurrentPedWeapon(cache.ped, 0xA2719263, true) -- set unarmed
            SetCurrentPedWeapon(cache.ped, joaat('weapon_unarmed'))
            PauseOpen = false
        end
    end
end)

-- Disable Controls 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3)
        --DisableControlAction(0, 0xAC4BD4F1, true) -- Disable weapon wheel | TAB (while holding)
        --DisableControlAction(0, 0xB238FE0B, true) -- Disable toggle holster | TAB TAB (fast tapping)

        -- LEFT ALT HUD
        DisableControlAction(0, 0xCF8A4ECA, true) -- disable left alt hud | LEFT ALT (fast tapping)
    end
end)

-- Handle Dead or Dying Animals
CreateThread(function()
    local pedPool = {}
    while true do
        sleep = 900000 -- every 15 mins
        local pedPool = GetGamePool('CPed')
        for i = 1, #pedPool do
            local ped = pedPool[i]
            local animal = GetIsAnimal(pedPool[i])
            if IsPedDeadOrDying(ped) == 1 and animal then
                SetEntityAsNoLongerNeeded(ped)
                --DeleteEntity(ped) -- this will delete animals in trasit to the butcher!
            end
        end
        Wait(sleep)
    end
end)
