-- removes events and challenge notifications
CreateThread(function()
    while true do
        Wait(10)
        local size = GetNumberOfEvents(0)
        if size > 0 then
            for i = 0, size - 1 do
                local eventRDO = GetEventAtIndex(0, i)
                if eventRDO == GetHashKey("EVENT_CHALLENGE_GOAL_COMPLETE") 
                or eventRDO == GetHashKey("EVENT_CHALLENGE_REWARD")
                or eventRDO == GetHashKey("EVENT_CHALLENGE_GOAL_UPDATE")
                or eventRDO == GetHashKey("EVENT_DAILY_CHALLENGE_STREAK_COMPLETED") then 
                    Citizen.InvokeNative(0x6035E8FBCA32AC5E)
                end
            end
        end
    end
end)

if Config.StopAutoShuffle then
    SetPedConfigFlag(cache.ped, 65, true) -- PCF_PreventAutoShuffleToDriversSeat
end
