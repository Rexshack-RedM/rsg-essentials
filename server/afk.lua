local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('rsg-essentials:server:afkKick', function()
    local src = source
    if not Config.AFK.Enabled then return end
    -- never trust the client: staff are exempt server-side too
    local groups = RSGCore.Functions.GetPermission(src) or {}
    for group in pairs(groups) do
        if Config.AFK.IgnoredGroups[group] then return end
    end
    DropPlayer(src, locale('sv_kick'))
end)

RSGCore.Functions.CreateCallback('rsg-essentials:server:getPermissions', function(source, cb)
    cb(RSGCore.Functions.GetPermission(source) or {})
end)
