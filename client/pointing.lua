local RSGCore = exports['rsg-core']:GetCoreObject()
local dict = 'script_common@other@unapproved'
local pointing = false

local function startPointing()
    if pointing then return end
    pointing = true
    RequestAnimDict(dict)
    local timeout = GetGameTimer() + 3000
    while not HasAnimDictLoaded(dict) and GetGameTimer() < timeout do Wait(50) end
    if not pointing then return end -- key was released while the dictionary loaded
    TaskPlayAnim(PlayerPedId(), dict, 'loop_0', 1.0, -1.0, -1, 30, 0, true, 0, false, 0, false)
end

local function stopPointing()
    if not pointing then return end
    pointing = false
    ClearPedSecondaryTask(PlayerPedId())
end

if Config.UseKeyMapping then
    -- rebindable hold key (rsg-core RegisterKey): no per-frame loop
    RSGCore.Functions.RegisterKey('rsgessentials_point', locale('key_point'), Config.Keys.Point, startPointing, stopPointing)
else
    CreateThread(function()
        local keybind = RSGCore.Shared.Keybinds[Config.Keys.Point]
        while true do
            Wait(7)
            if IsControlPressed(0, keybind) then
                startPointing()
                Wait(500)
            else
                stopPointing()
            end
        end
    end)
end

AddEventHandler('onResourceStop', function(res)
    if res == GetCurrentResourceName() then stopPointing() end
end)
