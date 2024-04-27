local RSGCore = exports['rsg-core']:GetCoreObject()
local pointing = false

CreateThread(function()
    while true do
        Wait(0)

        if IsControlPressed(0, RSGCore.Shared.Keybinds['B']) then
            if not pointing then
                pointing = true
                RequestAnimDict('script_common@other@unapproved')
                while not HasAnimDictLoaded('script_common@other@unapproved') do
                    Wait(100)
                end
                TaskPlayAnim(cache.ped, 'script_common@other@unapproved', 'loop_0', 1.0, -1.0, 9999999999, 30, 0, true, 0, false, 0, false)
            end
            Wait(500)
        else
            if pointing then
                pointing = false
                ClearPedSecondaryTask(cache.ped)
            end
        end
    end
end)
