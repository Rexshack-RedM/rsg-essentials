local PauseOpen = false

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        if IsPauseMenuActive() and not PauseOpen then
            SetCurrentPedWeapon(ped, 0xA2719263, true) -- set unarmed
            SetCurrentPedWeapon(ped, GetHashKey("weapon_unarmed"))
            if not IsPedOnMount(ped) then
                TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_SIT_GROUND_READING_BOOK"), -1, true, "StartScenario", 0, false)
            end
            PauseOpen = true
        end

        if not IsPauseMenuActive() and PauseOpen then
            ClearPedTasks(ped)
            Wait(4000)
            SetCurrentPedWeapon(ped, 0xA2719263, true) -- set unarmed
            SetCurrentPedWeapon(ped, GetHashKey("weapon_unarmed"))
            PauseOpen = false
        end
    end
end)
