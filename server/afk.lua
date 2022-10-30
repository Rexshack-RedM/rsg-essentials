local QRCore = exports['qr-core']:GetCoreObject()

RegisterNetEvent('KickForAFK', function()
	DropPlayer(source, 'You Have Been Kicked For Being AFK')
end)

QRCore.Functions.CreateCallback('rsg-afkkick:server:GetPermissions', function(source, cb)
    cb(QRCore.Functions.GetPermission(source))
end)