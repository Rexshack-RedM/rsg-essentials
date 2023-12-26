RegisterNetEvent('rsg-discord:getdata', function()
    local activePlayers = GetPlayers()
    local playerName = GetPlayerName(source)
    local maxServerCapacity = GetConvarInt("sv_maxClients", 48)
    local template = Config.Discord.Template

    local replacements = {
        ["{ID}"] = source,
        ["{NAME}"] = playerName,
        ["{PLAYERS_COUNT}"] = #activePlayers .. "/" .. maxServerCapacity,
    }

    local pattern = "{(.-)}"
    local result = template:gsub(pattern, function(key)
        return replacements['{' .. key .. '}'] or key
    end)

    TriggerClientEvent('rsg-discord:receivedata', source, result)
end)
