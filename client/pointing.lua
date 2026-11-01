local RSGCore = exports['rsg-core']:GetCoreObject()
local dict = 'script_common@other@unapproved'

CreateThread(function()
    local keybind = RSGCore.Shared.Keybinds['B']
    local pointing = false
    while true do
        Wait(7)
        if IsControlPressed(0, keybind) then
            if not pointing then
                pointing = true
                RequestAnimDict(dict)
                local timeout = GetGameTimer() + 3000
                while not HasAnimDictLoaded(dict) and GetGameTimer() < timeout do Wait(50) end
                TaskPlayAnim(PlayerPedId(), dict, 'loop_0', 1.0, -1.0, -1, 30, 0, true, 0, false, 0, false)
            end
            Wait(500)
        elseif pointing then
            pointing = false
            ClearPedSecondaryTask(PlayerPedId())
        end
    end
end)
