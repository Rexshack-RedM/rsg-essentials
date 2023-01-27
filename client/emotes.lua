-- [[ Exports ]] --
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

-- [[ Events ]] --
RegisterNetEvent("emotes:client:doemote")
AddEventHandler("emotes:client:doemote", function(data)
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

-- [[ Emote Menu ]] --

RegisterNetEvent('emotes:client:EmoteMenu', function()
    exports['rsg-menu']:openMenu({{
        header = 'Emote Menu',
        isMenuHeader = true -- Set to true to make a nonclickable title
    }, {
        header = '🚩 Actions',
        params = {
            event = 'emotes:client:actionemotes',
        }
    }, {
        header = '👋 Greeting',
        params = {
            event = 'emotes:client:greetemotes'
        }
    }, {
        header = '🎭 Reactions',
        params = {
            event = 'emotes:client:reactionemotes'
        }
    },{
        header = '😡 Taunting',
        params = {
            event = 'emotes:client:tauntemotes'
        }
    },{
        header = '💃 Dancing',
        params = {
            event = 'emotes:client:danceemotes'
        }
    }, {
        header = '❌ Exit',
    }})
end)

RegisterNetEvent('emotes:client:actionemotes', function()
    Citizen.Wait(500)
    local EmoteMenu = {{
        header = '🚩 Action Emotes',
        isMenuHeader = true -- Set to true to make a nonclickable title
    }, {
        header = '❌ Exit',
    }}
    for k, v in pairs(Config.Emotes.Actions) do
        EmoteMenu[#EmoteMenu + 1] = {
            header = "/"..k,
            txt = v.desc,
            params = {
                event = 'emotes:client:doemote',
                args = {
                    emote = v.anim,
                }
            }
        }
    end
    exports['rsg-menu']:openMenu(EmoteMenu)
end)

RegisterNetEvent('emotes:client:greetemotes', function()
    Citizen.Wait(500)
    local EmoteMenu = {{
        header = '👋 Greeting Emotes',
        isMenuHeader = true -- Set to true to make a nonclickable title
    }, {
        header = '❌ Exit',
    }}
    for k, v in pairs(Config.Emotes.Greeting) do
        EmoteMenu[#EmoteMenu + 1] = {
            header = "/"..k,
            txt = v.desc,
            params = {
                event = 'emotes:client:doemote',
                args = {
                    emote = v.anim,
                }
            }
        }
    end
    exports['rsg-menu']:openMenu(EmoteMenu)
end)

RegisterNetEvent('emotes:client:reactionemotes', function()
    Citizen.Wait(500)
    local EmoteMenu = {{
        header = '🎭 Reactions Emotes',
        isMenuHeader = true -- Set to true to make a nonclickable title
    }, {
        header = '❌ Exit',
    }}
    for k, v in pairs(Config.Emotes.Reactions) do
        EmoteMenu[#EmoteMenu + 1] = {
            header = "/"..k,
            txt = v.desc,
            params = {
                event = 'emotes:client:doemote',
                args = {
                    emote = v.anim,
                }
            }
        }
    end
    exports['rsg-menu']:openMenu(EmoteMenu)
end)

RegisterNetEvent('emotes:client:tauntemotes', function()
    Citizen.Wait(500)
    local EmoteMenu = {{
        header = '😡 Taunt Emotes',
        isMenuHeader = true -- Set to true to make a nonclickable title
    }, {
        header = '❌ Exit',
    }}
    for k, v in pairs(Config.Emotes.Taunting) do
        EmoteMenu[#EmoteMenu + 1] = {
            header = "/"..k,
            txt = v.desc,
            params = {
                event = 'emotes:client:doemote',
                args = {
                    emote = v.anim,
                }
            }
        }
    end
    exports['rsg-menu']:openMenu(EmoteMenu)
end)

RegisterNetEvent('emotes:client:danceemotes', function()
    Citizen.Wait(500)
    local EmoteMenu = {{
        header = '💃 Dance Emotes',
        isMenuHeader = true -- Set to true to make a nonclickable title
    }, {
        header = '❌ Exit',
    }}
    for k, v in pairs(Config.Emotes.Dancing) do
        EmoteMenu[#EmoteMenu + 1] = {
            header = "/"..k,
            txt = v.desc,
            params = {
                event = 'emotes:client:dodictemote',
                args = {
                    dict = v.dict,
                    anim = v.anim,
                    duration = v.duration,
                }
            }
        }
    end
    exports['rsg-menu']:openMenu(EmoteMenu)
end)