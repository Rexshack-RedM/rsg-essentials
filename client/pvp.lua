local QRCore = exports['qr-core']:GetCoreObject()

Citizen.CreateThread(function()
    local active = false
    local timer = 0
    while true do 
        Wait(0)
        if IsControlJustPressed(0, QRCore.Shared.Keybinds['E']) then
            timer = 0
            active = true
            while  timer < 200 do 
                Wait(0)
                timer = timer + 1
                SetRelationshipBetweenGroups(1, `PLAYER`, `PLAYER`)
            end
            
            active = false
        end

        if IsControlJustPressed(0, QRCore.Shared.Keybinds['F']) then
			Wait(500)
			SetRelationshipBetweenGroups(1, `PLAYER`, `PLAYER`)
			active = false
			timer = 0
        end
            
        if active == false and not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) then
            SetRelationshipBetweenGroups(5, `PLAYER`, `PLAYER`)
        end	
    end
end)
