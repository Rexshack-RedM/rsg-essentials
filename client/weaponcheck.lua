RegisterNetEvent('rsg-core:client:RemoveWeaponFromTab', function(weaponName)
    local ped = PlayerPedId()
    local weaponHash = GetHashKey(weaponName)
    local weapon = GetPedCurrentHeldWeapon(PlayerPedId())
    local serial = exports['rsg-weapons']:weaponInHands()
    local weaponTypeSlot = Citizen.InvokeNative(0x46F032B8DDF46CDE, weaponHash)

    local weaponInSlot = Citizen.InvokeNative(0xDBC4B552B2AE9A83, ped, weaponTypeSlot)

    if weaponInSlot then
        exports['rsg-weapons']:RemoveWeaponFromPeds(weaponName, serial[weaponHash])
    end

    if weaponHash == weapon then 
        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    end
end)
