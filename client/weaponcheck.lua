RegisterNetEvent('rsg-core:client:RemoveWeaponFromTab', function(weaponName)
    local ped = PlayerPedId()
    local weaponHash = GetHashKey(weaponName)
    local weapon = GetPedCurrentHeldWeapon(PlayerPedId())
    RemoveWeaponFromPed(ped, weaponHash)
    if weaponHash == weapon then
        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    end
end)