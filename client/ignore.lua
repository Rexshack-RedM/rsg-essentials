-- removes events and challenge notfications
CreateThread(function()
    while true do
        Wait(10)
        local size = GetNumberOfEvents(0)   
        if size > 0 then
            for i = 0, size - 1 do
                local eventAtIndex = GetEventAtIndex(0, i)
                if eventAtIndex == joaat('EVENT_CHALLENGE_GOAL_COMPLETE') or eventAtIndex == joaat('EVENT_CHALLENGE_REWARD') or eventAtIndex == joaat('EVENT_DAILY_CHALLENGE_STREAK_COMPLETED') then 
                    UiFeedClearAllChannels()
                end
            end
        end
    end
end)
