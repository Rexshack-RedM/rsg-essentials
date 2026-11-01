local RSGCore = exports['rsg-core']:GetCoreObject()

-- per-frame fixes: ped drown / boat sink + disabled controls
CreateThread(function()
    while true do
        Wait(0)
        SetPedResetFlag(PlayerPedId(), 364, true)
        DisableControlAction(0, 0xCF8A4ECA, true) -- left alt hud
        DisableControlAction(0, 0x9CC7A1A4, true) -- ability loadout prompt
    end
end)

-- stuck wagon fix: only touches ambient wagons this client owns with no player on board
CreateThread(function()
    while true do
        Wait(1000)
        local myPed = PlayerPedId()
        local vehicles = GetGamePool('CVehicle')
        for i = 1, #vehicles do
            local wagon = vehicles[i]
            if IsVehicleStopped(wagon) and not IsEntityAMissionEntity(wagon)
                and NetworkHasControlOfEntity(wagon) then
                local horse = GetPedInDraftHarness(wagon, 0)
                if horse ~= 0 and IsPedWalking(horse) then
                    local driver = GetDriverOfVehicle(wagon)
                    if driver == 0 or (driver ~= myPed and not IsPedAPlayer(driver)) then
                        if driver ~= 0 then DeleteEntity(driver) end
                        RemoveVehicleLightPropSets(wagon)
                        RemoveVehiclePropSets(wagon)
                        DeleteEntity(wagon)
                    end
                end
            end
        end
    end
end)

-- pause menu reading animation
CreateThread(function()
    if not Config.PauseReadBook then return end
    local pauseOpen = false
    while true do
        Wait(100)
        local ped = PlayerPedId()
        local active = IsPauseMenuActive()
        if active and not pauseOpen then
            pauseOpen = true
            SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
            if not IsPedOnMount(ped) and not IsPedInAnyVehicle(ped, false) then
                TaskStartScenarioInPlace(ped, `WORLD_HUMAN_SIT_GROUND_READING_BOOK`, -1, true, 'StartScenario', 0, false)
            end
        elseif not active and pauseOpen then
            pauseOpen = false
            ClearPedTasks(ped)
            Wait(4000)
            SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
        end
    end
end)

-- dead animal cleanup / thanks to rms_dnb
CreateThread(function()
    if not Config.EnableAnimalCleanup then return end
    local debug = Config.Debug
    while true do
        Wait(Config.CleanupInterval)
        local peds = GetGamePool('CPed')
        local removed = 0
        for i = 1, #peds do
            local ped = peds[i]
            if Citizen.InvokeNative(0x9A100F1CF4546629, ped) -- IS_PED_AN_ANIMAL
                and IsEntityDead(ped)
                and not IsEntityAttachedToAnyPed(ped)  -- being carried
                and not IsEntityAMissionEntity(ped)    -- owned by a script (hunting wagons, stables...)
                and NetworkHasControlOfEntity(ped) then
                DeleteEntity(ped)
                if DoesEntityExist(ped) then
                    SetEntityAsNoLongerNeeded(ped)
                else
                    removed = removed + 1
                end
            end
        end
        if debug then print(('[rsg-essentials] animal cleanup: %d peds scanned, %d dead animals removed'):format(#peds, removed)) end
    end
end)

-- pvp toggle (used by rsg-radialmenu)
local pvp = false
RegisterNetEvent('rsg-essentials:client:pvpToggle', function()
    local ped = PlayerPedId()
    pvp = not pvp
    SetRelationshipBetweenGroups(pvp and 5 or 1, `PLAYER`, `PLAYER`)
    NetworkSetFriendlyFireOption(pvp)
    if pvp then
        Citizen.InvokeNative(0x949B2F9ED2917F5D, ped, 6) -- enable choking
    else
        Citizen.InvokeNative(0xB8DE69D9473B7593, ped, 6) -- disable choking
    end
    RSGCore.Functions.Notify({ id = 'rsg_pvp', title = locale(pvp and 'cl_pvp_toggle_on' or 'cl_pvp_toggle_off'), type = 'inform', icon = 'fa-solid fa-shield', duration = 7000 })
end)
