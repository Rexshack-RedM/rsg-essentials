RegisterNetEvent("emotes:client:doemote")
AddEventHandler("emotes:client:doemote", function(emote)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, emote, 1, 1, 0, 0)
end)

-- emote from animation, doesn't have to be a dance
RegisterNetEvent("emotes:client:dodance")
AddEventHandler("emotes:client:dodance", function(dict,anim)
    	local playerPed = PlayerPedId()
    	local animDict = dict
	RequestAnimDict(animDict)
	Citizen.InvokeNative(0xEA47FE3719165B94, playerPed, animDict, anim, 8.0, -8.0, 9000, 1, 0, true, 0, false, 0, false)
end)
