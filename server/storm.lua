lib.locale()

-- Weather stages before a txAdmin scheduled restart
local stages = {
    [1800] = { weather = 'drizzle',      msg = 'sv_print_drizzle' },      -- 30 mins
    [900]  = { weather = 'shower',       msg = 'sv_print_shower' },       -- 15 mins
    [600]  = { weather = 'rain',         msg = 'sv_print_rain' },         -- 10 mins
    [300]  = { weather = 'thunderstorm', msg = 'sv_print_thunderstorm' }, -- 5 mins
}

local function setStormWeather(weather)
    if GetResourceState('rsg-weather') ~= 'started' then
        print(('^3[rsg-essentials] rsg-weather is not started, cannot set weather to %s^7'):format(weather))
        return false
    end

    local ok, result = pcall(function()
        return exports['rsg-weather']:setWeather(weather, 10.0, false, false)
    end)
    if not ok or result == false then
        print(('^3[rsg-essentials] rsg-weather failed to set weather to %s^7'):format(weather))
        return false
    end
    return true
end

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    local stage = stages[eventData.secondsRemaining]
    if not stage then return end

    if setStormWeather(stage.weather) then
        print(locale(stage.msg))
    end
end)
