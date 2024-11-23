local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

RSGCore.Commands.Add('bandana', locale('sv_bandana'), {}, false, function(source)
    local src = source
    TriggerClientEvent('rsg-bandana:client:ToggleBandana', src)
end)