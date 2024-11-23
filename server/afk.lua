local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

RegisterNetEvent('KickForAFK', function()
    DropPlayer(source, locale('sv_kick'))
end)

RSGCore.Functions.CreateCallback('rsg-afkkick:server:GetPermissions', function(source, cb)
    cb(RSGCore.Functions.GetPermission(source))
end)
