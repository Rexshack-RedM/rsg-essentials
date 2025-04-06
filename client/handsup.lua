local RSGCore = exports['rsg-core']:GetCoreObject()

CreateThread(function()
    while true do
        Wait(7)

        local keybind = RSGCore.Shared.Keybinds['X']

        if IsControlJustPressed(0, keybind) then
            RSGCore.Functions.GetPlayerData(function(PlayerData)
                if not PlayerData.metadata["isdead"]
                and not IsEntityDead(cache.ped) -- unconditional death
                and not PlayerData.metadata["ishandcuffed"]
                and not Citizen.InvokeNative(0x9682F850056C9ADE, cache.ped) then
                    local animDict = "script_proc@robberies@homestead@lonnies_shack@deception"

                    if not IsEntityPlayingAnim(cache.ped, animDict, "hands_up_loop", 3) then
                        SetCurrentPedWeapon(cache.ped, joaat('weapon_unarmed'))
                        LocalPlayer.state:set("inv_busy", true, true)

                        if not HasAnimDictLoaded(animDict) then
                            RequestAnimDict(animDict)
                            while not HasAnimDictLoaded(animDict) do
                                Wait(0)
                            end
                        end

                        TaskPlayAnim(cache.ped, animDict, "hands_up_loop", 2.0, -2.0, -1, 67109393, 0.0, false, 1245184, false, "UpperbodyFixup_filter", false)
                        RequestAnimDict(animDict)
                    else
                        ClearPedSecondaryTask(cache.ped)
                        LocalPlayer.state:set("inv_busy", false, true)
                    end
                end
            end)
        end
    end
end)
