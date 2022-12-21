-- emotes using TaskPlayEmoteWithHash (0xB31A277C1AC7B7FF)
RegisterNetEvent("emotes:client:doemote")
AddEventHandler("emotes:client:doemote", function(emote)
    Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, emote, 1, 1, 0, 0)
end)

-- emotes using TaskPlayAnim (0xEA47FE3719165B94)
RegisterNetEvent("emotes:client:dodictemote")
AddEventHandler("emotes:client:dodictemote", function(dict, anim, duration)
    local ped = PlayerPedId()
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(100)
    end
    Citizen.InvokeNative(0xEA47FE3719165B94, ped, dict, anim, 8.0, -8.0, duration, 1, 0, true, 0, false, 0, false)
end)
