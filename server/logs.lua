local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

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

local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
}

RegisterNetEvent('rsg-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = Config.DiscordWHAuthorName,
                ['icon_url'] = Config.DiscordWHImage,
            },
        }
    }
    PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = Config.DiscordWHLogUserName, embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = Config.DiscordWHLogUserName, content = '@everyone'}), { ['Content-Type'] = 'application/json' })
    end
end)

RSGCore.Commands.Add('testwebhook', locale('sv_test_your_webhook'), {}, false, function()
    TriggerEvent('rsg-log:server:CreateLog', 'testwebhook', locale('sv_test_webhook'), 'default', locale('sv_webhook_successfully'))
end, 'god')
