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

-- handle dead or dying animals / thanks to rms_dnb
local pickedUpAnimals = {}

CreateThread(function()
    while true do
        local sleep = 900000 -- every 15 min
        print("Starting dead animal cleanup cycle")
        local pedPool = GetGamePool('CPed')
        print("Number of PEDs in pool: " .. #pedPool)
        local deadAnimalsCount = 0

        for i = 1, #pedPool do
            local ped = pedPool[i]
            
            -- Check if the ped is an animal
            if Citizen.InvokeNative(0x9A100F1CF4546629, ped) and IsEntityDead(ped) then
                print("Dead animal found: " .. ped)
                
                -- Check if the animal is attached to another entity
                if IsEntityAttached(ped) then
                    -- Mark the animal as picked up
                    pickedUpAnimals[ped] = true
                    print("Animal is attached and marked as picked up: " .. ped)
                elseif not pickedUpAnimals[ped] then
                    -- Check if the entity still exists
                    if DoesEntityExist(ped) then
                        -- Try to delete the entity
                        DeleteEntity(ped)
                        
                        -- Check if deletion was successful
                        if DoesEntityExist(ped) then
                            print("Failed to delete animal: " .. ped)
                            SetEntityAsNoLongerNeeded(ped)
                            SetEntityHealth(ped, 0)
                        else
                            print("Successfully deleted animal: " .. ped)
                            deadAnimalsCount = deadAnimalsCount + 1
                        end
                    else
                        print("Animal no longer exists: " .. ped)
                    end
                else
                    print("Animal was picked up previously and will not be deleted: " .. ped)
                end
            end
        end
        print("Dead animals processed: " .. deadAnimalsCount)
        print("Cleanup cycle complete. Waiting for next cycle...")
        Wait(sleep)
    end
end)
