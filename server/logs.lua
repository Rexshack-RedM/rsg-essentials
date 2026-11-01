local RSGCore = exports['rsg-core']:GetCoreObject()

-- add your discord webhook urls here (empty = channel disabled, falls back to 'default')
local Webhooks = {
    ['default'] = '',
    ['testwebhook'] = '',
    ['anticheat'] = '',
    ['levels'] = '',
    ['playermoney'] = '',
    ['joinleave'] = '',
    ['banking'] = '',
    ['ooc'] = '',
    ['playerinventory'] = '',
    ['robbing'] = '',
    ['stash'] = '',
    ['drop'] = '',
    ['dealers'] = '',
    ['shops'] = '',
    ['bans'] = '',
    ['bossmenu'] = '',
    ['gangmenu'] = '',
    ['fishing'] = '',
    ['goldpanning'] = '',
    ['loot'] = '',
    ['hotel'] = '',
    ['beekeeper'] = '',
    ['ranch'] = '',
    ['adminmenu'] = '',
    ['report'] = '',
    ['horsetrainer'] = '',
    ['crafting'] = '',
    ['death'] = '',
}

local Colors = {
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ['lightgreen'] = 65309,
}

local CLIENT_COOLDOWN = 2 -- seconds between client-sent logs per player
local lastClientLog = {}

local function post(url, payload)
    PerformHttpRequest(url, function() end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

local function sendLog(name, title, color, message, tagEveryone)
    local url = Webhooks[name]
    if not url or url == '' then url = Webhooks['default'] end
    if not url or url == '' then return end

    post(url, {
        username = Config.DiscordWHLogUserName,
        embeds = {{
            title = title,
            color = Colors[color] or Colors['default'],
            description = message,
            footer = { text = os.date('%c') },
            author = { name = Config.DiscordWHAuthorName, icon_url = Config.DiscordWHImage },
        }},
    })
    if tagEveryone then
        SetTimeout(100, function()
            post(url, { username = Config.DiscordWHLogUserName, content = '@everyone' })
        end)
    end
end

-- server resources: TriggerEvent('rsg-log:server:CreateLog', name, title, color, message, tagEveryone)
-- clients may still send logs (rsg-adminmenu does), but are rate limited, can't @everyone
-- and are tagged with their server id so spoofed logs are traceable
RegisterNetEvent('rsg-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local src = tonumber(source)
    if type(name) ~= 'string' then return end
    title, message = tostring(title or ''):sub(1, 256), tostring(message or ''):sub(1, 4000)

    if src and src > 0 then
        local now = os.time()
        if lastClientLog[src] and now - lastClientLog[src] < CLIENT_COOLDOWN then return end
        lastClientLog[src] = now
        tagEveryone = false
        message = ('%s\n\n`client: [%d] %s`'):format(message, src, GetPlayerName(src) or '?')
    end

    sendLog(name, title, color, message, tagEveryone == true)
end)

AddEventHandler('playerDropped', function()
    lastClientLog[source] = nil
end)

RSGCore.Commands.Add('testwebhook', locale('sv_test_your_webhook'), {}, false, function()
    sendLog('testwebhook', locale('sv_test_webhook'), 'default', locale('sv_webhook_successfully'))
end, 'god')
