local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('rsg-core:client:RemoveWeaponFromTab', function(weaponName)
    if type(weaponName) ~= 'string' then return end
    local ped = PlayerPedId()
    local weaponHash = joaat(weaponName)
    local slot = Citizen.InvokeNative(0x46F032B8DDF46CDE, weaponHash) -- GET_WEAPONTYPE_SLOT
    if Citizen.InvokeNative(0xDBC4B552B2AE9A83, ped, slot) then -- HAS_PED_GOT_WEAPON_IN_SLOT
        local serials = exports['rsg-weapons']:weaponInHands() or {}
        exports['rsg-weapons']:RemoveWeaponFromPeds(weaponName, serials[weaponHash])
    end
    if GetPedCurrentHeldWeapon(ped) == weaponHash then
        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    end
end)

-- removes any held weapon the player doesn't have in their inventory
CreateThread(function()
    while true do
        Wait(1000)
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            local weapon = Citizen.InvokeNative(0x8425C5F057012DAB, ped) -- GET_PED_CURRENT_HELD_WEAPON
            local data = RSGCore.Shared.Weapons[weapon]
            if data and data.name ~= 'weapon_unarmed'
                and Citizen.InvokeNative(0xEDCA14CA5199FF25, weapon) ~= `group_thrown` -- GET_WEAPONTYPE_GROUP
                and not RSGCore.Functions.HasItem(data.name) then
                SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
                RemoveWeaponFromPed(ped, weapon)
            end
        end
    end
end)
