-- removes events and challenge notifications
-- hashes resolved once instead of 4x GetHashKey per event every tick
local IgnoredEvents = {
    [joaat("EVENT_CHALLENGE_GOAL_COMPLETE")] = true,
    [joaat("EVENT_CHALLENGE_REWARD")] = true,
    [joaat("EVENT_CHALLENGE_GOAL_UPDATE")] = true,
    [joaat("EVENT_DAILY_CHALLENGE_STREAK_COMPLETED")] = true,
}
CreateThread(function()
    while true do
        Wait(10)
        local size = GetNumberOfEvents(0)
        for i = 0, size - 1 do
            if IgnoredEvents[GetEventAtIndex(0, i)] then
                Citizen.InvokeNative(0x6035E8FBCA32AC5E)
            end
        end
    end
end)

if Config.StopAutoShuffle then
    SetPedConfigFlag(cache.ped, 65, true) -- PCF_PreventAutoShuffleToDriversSeat
end
