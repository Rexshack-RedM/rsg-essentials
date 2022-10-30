local QRCore = exports['qr-core']:GetCoreObject()
local isBusy = false

function loadAnimDict(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

function loadModel(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

function doAnim (Amodel, bone, pX, pY, pZ, rX, rY, rZ, anim, Adict, duration)
    local model = loadModel(GetHashKey(Amodel))
    object = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
    AttachEntityToEntity(object, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), bone), pX, pY, pZ, rX, rY, rZ, false, true, true, true, 0, true)
    local dict = loadAnimDict(Adict)
    TaskPlayAnim(PlayerPedId(), dict, anim, 5.0, 5.0, duration, 1, false, false, false)
end

function AnimDetatch (sleep)
    Citizen.Wait(sleep)
    if object ~= nil then
        DetachEntity(object, true, true)
        DeleteObject(object)
    end
end

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    SetTextScale(0.30, 0.30)
    SetTextFontForCurrentCommand(9)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

-- pump prompt
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local pumpObject = GetClosestObjectOfType(pos, 5.0, GetHashKey("p_waterpump01x"), false, false, false)
		if pumpObject ~= 0 then
			local objectPos = GetEntityCoords(pumpObject)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "USE [J]")
				if IsControlJustReleased(0, QRCore.Shared.Keybinds['J']) then
					TriggerEvent('rsg-waterpump:client:drinking')
				end
			end
		end
		if awayFromObject then
			Citizen.Wait(1000)
		end
	end
end)

-- well pump prompt
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local wellpumpObject = GetClosestObjectOfType(pos, 5.0, GetHashKey("p_wellpumpnbx01x"), false, false, false)
		if wellpumpObject ~= 0 then
			local objectPos = GetEntityCoords(wellpumpObject)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "USE [J]")
				if IsControlJustReleased(0, QRCore.Shared.Keybinds['J']) then 
					TriggerEvent('rsg-waterpump:client:drinking')
				end
			end
		end
		if awayFromObject then
			Citizen.Wait(1000)
		end
	end
end)

-- waterpump drink water
RegisterNetEvent('rsg-waterpump:client:drinking', function()
    if isBusy then
        return
    else
        isBusy = not isBusy
        local sleep = 5000
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"))
        Citizen.Wait(100)
        if not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) then
            local object = nil
            doAnim("p_mugcoffee01x", "SKEL_R_FINGER12", 0.0, -0.05, 0.03, 0.0, 180.0, 180.0, 'action', 'mech_inventory@drinking@coffee', sleep)
        end
		Wait(sleep)
		TriggerServerEvent("QRCore:Server:SetMetaData", "thirst", QRCore.Functions.GetPlayerData().metadata["thirst"] + math.random(25, 50))
        ClearPedTasks(PlayerPedId())
        AnimDetatch (sleep)
        isBusy = not isBusy
    end
end)
