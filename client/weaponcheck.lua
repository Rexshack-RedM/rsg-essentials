local RSGCore = exports['rsg-core']:GetCoreObject()

CreateThread(function()
    while true do
        Wait(5000)
        local weapon = GetPedCurrentHeldWeapon(cache.ped)
        local WeaponData = RSGCore.Shared.Weapons[weapon]
        if WeaponData ~= nil and WeaponData['name'] ~= 'weapon_unarmed' then
            local weaponGroup = GetWeapontypeGroup(weapon)
            if weaponGroup ~= `group_thrown` then
                RSGCore.Functions.GetPlayerData(function(PlayerData)
                    firstname = PlayerData.charinfo.firstname
                    lastname = PlayerData.charinfo.lastname
                    fullname = firstname..' '..lastname
                end)
                local hasItem = RSGCore.Functions.HasItem(WeaponData['name'])
                if not hasItem then
                    SetCurrentPedWeapon(cache.ped, `WEAPON_UNARMED`, true)
                    RemoveAllPedWeapons(cache.ped, true, true)
                    TriggerServerEvent("rsg-log:server:CreateLog", "anticheat",  Lang:t('log.weapon_removed'), "orange", '** @staff ** '..fullname..' had a weapon on them that they did not have in his inventory : anticheat has removed the weapon')
                end
            end
        end
    end
end)
