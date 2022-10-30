local QRCore = exports['qr-core']:GetCoreObject()

CreateThread(function()	-- Check if player has weapon in inventory --
    while true do
        Wait(5000)
		local player = PlayerPedId()
		local weapon = Citizen.InvokeNative(0x8425C5F057012DAB, player)
		local WeaponData = QRCore.Shared.Weapons[weapon]
		if WeaponData ~= nil and WeaponData["name"] ~= "weapon_unarmed" then
			QRCore.Functions.GetPlayerData(function(PlayerData)
				firstname = PlayerData.charinfo.firstname
				lastname = PlayerData.charinfo.lastname
			end)
			local hasItem = QRCore.Functions.HasItem(WeaponData["name"])
			--print(hasItem)
			if not hasItem then
				SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
				RemoveAllPedWeapons(player, true, true)
				TriggerServerEvent("qr-log:server:CreateLog", "anticheat", "Weapon Removed!", "orange", "** @staff ** " ..firstname.. " " ..lastname.. " had a weapon on them that they did not have in his inventory : anticheat has removed the weapon")
			end
		end
    end
end)