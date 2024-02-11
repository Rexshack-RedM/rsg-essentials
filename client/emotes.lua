-------------------------------------------------------
-- exports
-------------------------------------------------------
local function doemote(emote)
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, emote, 1, 1, 0, 0)
end exports('doemote', doemote)

local function dodictemote(dict, anim, duration)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(100)
    end
    Citizen.InvokeNative(0xEA47FE3719165B94, PlayerPedId(), dict, anim, 8.0, -8.0, duration, 1, 0, true, 0, false, 0, false)
end exports('dodictemote', dodictemote)

-------------------------------------------------------
-- events
-------------------------------------------------------
RegisterNetEvent("emotes:client:doemote")
AddEventHandler("emotes:client:doemote", function(data)
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, data, 1, 1, 0, 0)
end)

RegisterNetEvent("emotes:client:doemotemenu")
AddEventHandler("emotes:client:doemotemenu", function(data)
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, data.emote, 1, 1, 0, 0)
end)

RegisterNetEvent("emotes:client:dodictemote")
AddEventHandler("emotes:client:dodictemote", function(data)
    local ped = PlayerPedId()
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(100)
    end
    Citizen.InvokeNative(0xEA47FE3719165B94, ped, data.dict, data.anim, 8.0, -8.0, data.duration, 1, 0, true, 0, false, 0, false)
end)

-------------------------------------------------------
-- main emote menu
-------------------------------------------------------
RegisterNetEvent('emotes:client:EmoteMenu', function()
    lib.registerContext(
        {
            id = 'emotes_mainmenu',
            title = Lang:t('emotes.title'),
            position = 'top-right',
            options = {
                {
                    title = Lang:t('emotes.actions.mainMenu'),
                    icon = 'fa-solid fa-icons',
                    event = 'emotes:client:actionemotes'
                },
                {
                    title = Lang:t('emotes.greeting.mainMenu'),
                    icon = 'fa-solid fa-icons',
                    event = 'emotes:client:greetingemotes'
                },
                {
                    title = Lang:t('emotes.reaction.mainMenu'),
                    icon = 'fa-solid fa-icons',
                    event = 'emotes:client:reactionemotes'
                },
                {
                    title = Lang:t('emotes.taunting.mainMenu'),
                    icon = 'fa-solid fa-icons',
                    event = 'emotes:client:tauntemotes'
                },
                {
                    title = Lang:t('emotes.dancing.mainMenu'),
                    icon = 'fa-solid fa-icons',
                    event = 'emotes:client:dancingemotes'
                },
            }
        }
    )
    lib.showContext('emotes_mainmenu')
end)

-------------------------------------------------------
-- actions emote menu
-------------------------------------------------------
RegisterNetEvent('emotes:client:actionemotes', function()
    local options = {}
    for k,v in pairs(Config.Emotes.Actions) do
        options[#options + 1] = {
            title = "/"..k,
            description = v.desc,
            icon = 'fa-solid fa-icons',
            event = 'emotes:client:doemotemenu',
            args = { emote = v.anim },
            arrow = false,
        }
    end
    lib.registerContext({
        id = 'emotes_actionsmenu',
        title = Lang:t('emotes.actions.secondMenu'),
        menu = 'emotes_mainmenu',
        onBack = function() end,
        position = 'top-right',
        options = options
    })
    lib.showContext('emotes_actionsmenu')
end)

-------------------------------------------------------
-- greetings emote menu
-------------------------------------------------------
RegisterNetEvent('emotes:client:greetingemotes', function()
    local options = {}
    for k,v in pairs(Config.Emotes.Greeting) do
        options[#options + 1] = {
            title = "/"..k,
            description = v.desc,
            icon = 'fa-solid fa-icons',
            event = 'emotes:client:doemotemenu',
            args = { emote = v.anim },
            arrow = false,
        }
    end
    lib.registerContext({
        id = 'emotes_greetingmenu',
        title = Lang:t('emotes.greeting.secondMenu'),
        menu = 'emotes_mainmenu',
        onBack = function() end,
        position = 'top-right',
        options = options
    })
    lib.showContext('emotes_greetingmenu')
end)

-------------------------------------------------------
-- reaction emote menu
-------------------------------------------------------
RegisterNetEvent('emotes:client:reactionemotes', function()
    local options = {}
    for k,v in pairs(Config.Emotes.Reactions) do
        options[#options + 1] = {
            title = "/"..k,
            description = v.desc,
            icon = 'fa-solid fa-icons',
            event = 'emotes:client:doemotemenu',
            args = { emote = v.anim },
            arrow = false,
        }
    end
    lib.registerContext({
        id = 'emotes_reactionmenu',
        title = Lang:t('emotes.reaction.secondMenu'),
        menu = 'emotes_mainmenu',
        onBack = function() end,
        position = 'top-right',
        options = options
    })
    lib.showContext('emotes_reactionmenu')
end)

-------------------------------------------------------
-- taunt emote menu
-------------------------------------------------------
RegisterNetEvent('emotes:client:tauntemotes', function()
    local options = {}
    for k,v in pairs(Config.Emotes.Taunting) do
        options[#options + 1] = {
            title = "/"..k,
            description = v.desc,
            icon = 'fa-solid fa-icons',
            event = 'emotes:client:doemotemenu',
            args = { emote = v.anim },
            arrow = false,
        }
    end
    lib.registerContext({
        id = 'emotes_tauntmenu',
        title = Lang:t('emotes.taunting.secondMenu'),
        menu = 'emotes_mainmenu',
        onBack = function() end,
        position = 'top-right',
        options = options
    })
    lib.showContext('emotes_tauntmenu')
end)

-------------------------------------------------------
-- dancing emote menu
-------------------------------------------------------
RegisterNetEvent('emotes:client:dancingemotes', function()
    local options = {}
    for k,v in pairs(Config.Emotes.Dancing) do
        options[#options + 1] = {
            title = "/"..k,
            description = v.desc,
            icon = 'fa-solid fa-icons',
            event = 'emotes:client:dodictemote',
            args = {
                dict = v.dict,
                anim = v.anim,
                duration = v.duration,
            },
            arrow = false,
        }
    end
    lib.registerContext({
        id = 'emotes_dancingmenu',
        title = Lang:t('emotes.dancing.secondMenu'),
        menu = 'emotes_mainmenu',
        onBack = function() end,
        position = 'top-right',
        options = options
    })
    lib.showContext('emotes_dancingmenu')
end)
