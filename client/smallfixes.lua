local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()
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
    local keybind = RSGCore.Shared.Keybinds['RIGHTBRACKET']
    while true do
        Wait(7)
        if IsControlJustPressed(0, keybind) then
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
            if IsEntityAVehicle(wagon) and IsVehicleStopped(wagon) and not IsEntityAMissionEntity(wagon) then
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
                        RemoveVehicleLightPropSets(wagon)
                        RemoveVehiclePropSets(wagon)
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
        Wait(100)

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
        -- if WheelMenuSpace then
        --     DisableControlAction(0, 0xCF8A4ECA, true) -- disable left alt hud | LEFT ALT (fast tapping)
        -- end
        -- LEFT ALT HUD
        DisableControlAction(0, 0xCF8A4ECA, true) -- disable left alt hud | LEFT ALT (fast tapping)
        DisableControlAction(0, 0x9CC7A1A4, true) -- disable Ability Loadout prompt
    end
end)

-- handle dead or dying animals / thanks to rms_dnb
local pickedUpAnimals = {}
CreateThread(function()
    while true do
        local sleep = 900000 -- every 15 min
        print(locale('cl_clean_cycle'))
        local pedPool = GetGamePool('CPed')
        print(locale('cl_num_ped')..": " .. #pedPool)
        local deadAnimalsCount = 0

        for i = 1, #pedPool do
            local ped = pedPool[i]

            -- Check if the ped is an animal
            if Citizen.InvokeNative(0x9A100F1CF4546629, ped) and IsEntityDead(ped) then
                print(locale('cl_num_animal')..": " .. ped)

                -- Check if the animal is attached to another entity
                if IsEntityAttachedToAnyPed(ped) then
                    -- Mark the animal as picked up
                    pickedUpAnimals[ped] = true
                    print(locale('cl_num_animal_b')..": " .. ped)
                elseif not pickedUpAnimals[ped] then
                    -- Check if the entity still exists
                    if DoesEntityExist(ped) then
                        if GetPedTimeOfDeath(ped) < GetGameTimer() then --check if dead long enough
                            -- Try to delete the entity
                            DeleteEntity(ped)

                            -- Check if deletion was successful
                            if DoesEntityExist(ped) then
                                print(locale('cl_num_animal_c')..": " .. ped)
                                SetEntityAsNoLongerNeeded(ped)
                                SetEntityHealth(ped, 0)
                            else
                                print(locale('cl_num_animal_d')..": " .. ped)
                                deadAnimalsCount = deadAnimalsCount + 1
                            end
                        end
                    else
                        print(locale('cl_num_animal_e')..": " .. ped)
                    end
                else
                    print(locale('cl_num_animal_f')..": " .. ped)
                end
            end
        end
        print(locale('cl_num_animal_g')..": " .. deadAnimalsCount)
        print(locale('cl_num_animal_h'))
        Wait(sleep)
    end
end)

RegisterNetEvent('rsg-essentials:client:pvpToggle',function()
    local ped = PlayerPedId()

    if pvp == true then
        SetRelationshipBetweenGroups(1,`PLAYER`, `PLAYER`)
        NetworkSetFriendlyFireOption(false)
        Citizen.InvokeNative(0xB8DE69D9473B7593, ped, 6) -- Disable choking other people

        pvp = false

        lib.notify({ title = locale('cl_pvp_toggle_off'), type = 'info', icon = 'fa-solid fa-shield', iconAnimation = 'shake', duration = 7000 })
        return
    end

    SetRelationshipBetweenGroups(5, `PLAYER`, `PLAYER`)
    NetworkSetFriendlyFireOption(true)
    Citizen.InvokeNative(0x949B2F9ED2917F5D, ped, 6) -- Enable choking other people

    pvp = true

    lib.notify({ title = locale('cl_pvp_toggle_on'), type = 'info', icon = 'fa-solid fa-shield', iconAnimation = 'shake', duration = 7000 })

end)
