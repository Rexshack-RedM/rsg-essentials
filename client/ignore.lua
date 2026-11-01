-- removes challenge events / notifications
local IgnoredEvents = {
    [joaat('EVENT_CHALLENGE_GOAL_COMPLETE')] = true,
    [joaat('EVENT_CHALLENGE_REWARD')] = true,
    [joaat('EVENT_CHALLENGE_GOAL_UPDATE')] = true,
    [joaat('EVENT_DAILY_CHALLENGE_STREAK_COMPLETED')] = true,
}

CreateThread(function()
    while true do
        Wait(10)
        for i = 0, GetNumberOfEvents(0) - 1 do
            if IgnoredEvents[GetEventAtIndex(0, i)] then
                Citizen.InvokeNative(0x6035E8FBCA32AC5E)
            end
        end
    end
end)

-- stop auto-shuffle into the driver seat (re-applied on every character load, the ped changes)
local function applyNoShuffle()
    if Config.StopAutoShuffle then
        SetPedConfigFlag(PlayerPedId(), 65, true) -- PCF_PreventAutoShuffleToDriversSeat
    end
end
applyNoShuffle()
RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    Wait(1000)
    applyNoShuffle()
end)
