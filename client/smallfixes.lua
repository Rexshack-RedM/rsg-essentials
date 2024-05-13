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

-----------------------------
-- handle getting on other players horse (make friendly)
-----------------------------
CreateThread(function()
    local active = false
    local timer = 0

    while true do 

        Wait(0)

        if IsControlJustPressed(0, 0xCEFD9220) then -- E KEY
            timer = 0
            active = true
            while  timer < 200 do 
                Wait(0)
                timer = timer + 1
                SetRelationshipBetweenGroups(1, `PLAYER`, `PLAYER`)
            end
            active = false
        end

        if IsControlJustPressed(0, 0xB2F377E8) then -- F KEY
            Wait(500)
            SetRelationshipBetweenGroups(1, `PLAYER`, `PLAYER`)
            active = false
            timer = 0
        end

        if active == false and not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) then
            SetRelationshipBetweenGroups(5, `PLAYER`, `PLAYER`)
        end

    end
end)
