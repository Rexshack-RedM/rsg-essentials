local RSGCore = exports['rsg-core']:GetCoreObject()
local pointing = false

CreateThread(function()
    local keybind = RSGCore.Shared.Keybinds['B']
    while true do
        Wait(7)

        if IsControlPressed(0, keybind) then
            if not pointing then
                pointing = true
                RequestAnimDict('script_common@other@unapproved')
                while not HasAnimDictLoaded('script_common@other@unapproved') do
                    Wait(100)
                end
                TaskPlayAnim(cache.ped, 'script_common@other@unapproved', 'loop_0', 1.0, -1.0, -1, 30, 0, true, 0, false, 0, false)
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
