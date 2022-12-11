local QRCore = exports['qr-core']:GetCoreObject()

CreateThread(function()
    while true do
        Wait(7)
        if IsControlJustPressed(0, QRCore.Shared.Keybinds['X']) then
            local ped = PlayerPedId()
            if not IsEntityDead(ped) and not Citizen.InvokeNative(0x9682F850056C9ADE, ped) then
                local animDict = "script_proc@robberies@homestead@lonnies_shack@deception"
                if not IsEntityPlayingAnim(ped, animDict, "hands_up_loop", 3) then
                    if not HasAnimDictLoaded(animDict) then
                        RequestAnimDict(animDict)
                        while not HasAnimDictLoaded(animDict) do
                            Wait(0)
                        end
                    end
                    TaskPlayAnim(ped, animDict, "hands_up_loop", 2.0, -2.0, -1, 67109393, 0.0, false, 1245184, false, "UpperbodyFixup_filter", false)
                    RequestAnimDict(animDict)
                else
                    ClearPedSecondaryTask(ped)
                end
            end
        end
    end
end)