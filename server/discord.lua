-- discord rich presence text; built server-side on request (rate limited per player)
local lastRequest = {}

RegisterNetEvent('rsg-discord:getdata', function()
    local src = source
    local now = os.time()
    if lastRequest[src] and now - lastRequest[src] < 10 then return end
    lastRequest[src] = now

    local replacements = {
        ID = src,
        NAME = GetPlayerName(src) or '',
        PLAYERS_COUNT = ('%d/%d'):format(#GetPlayers(), GetConvarInt('sv_maxclients', 48)),
    }
    local text = Config.Discord.Template:gsub('{(.-)}', function(key)
        return tostring(replacements[key] or key)
    end)
    TriggerClientEvent('rsg-discord:receivedata', src, text)
end)

AddEventHandler('playerDropped', function()
    lastRequest[source] = nil
end)
