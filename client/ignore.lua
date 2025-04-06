-- removes events and challenge notfications
CreateThread(function()
    local hashComplete = joaat('EVENT_CHALLENGE_GOAL_COMPLETE')
    local hashReward = joaat('EVENT_CHALLENGE_REWARD')
    local hashDaily = joaat('EVENT_DAILY_CHALLENGE_STREAK_COMPLETED')

    while true do
        Wait(10)
        local size = GetNumberOfEvents(0)
        if size > 0 then
            for i = 0, size - 1 do
                local eventAtIndex = GetEventAtIndex(0, i)
                if eventAtIndex == hashComplete or eventAtIndex == hashReward or eventAtIndex == hashDaily then 
                    UiFeedClearAllChannels()
                end
            end
        end
    end
end)

if Config.StopAutoShuffle then
    SetPedConfigFlag(cache.ped, 65, true) -- PCF_PreventAutoShuffleToDriversSeat
end
