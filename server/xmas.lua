-- christmas snow pattern via rsg-weather (weathersync has been removed)
if not Config.EnableXmas then return end

local XmasPattern = {
    ['snowlight'] = { ['snow'] = 20, ['snowlight'] = 30, ['clouds'] = 50 },
    ['snow']      = { ['snow'] = 20, ['snowlight'] = 70, ['blizzard'] = 10 },
    ['blizzard']  = { ['snow'] = 90, ['blizzard'] = 10 },
    ['sunny']     = { ['sunny'] = 60, ['clouds'] = 40 },
    ['clouds']    = { ['sunny'] = 30, ['overcast'] = 70 },
    ['overcast']  = { ['clouds'] = 30, ['snowlight'] = 70 },
}

local function weatherReady()
    if GetResourceState('rsg-weather') == 'started' then return true end
    print('^3[rsg-essentials] Config.EnableXmas is on but rsg-weather is not started^7')
    return false
end

CreateThread(function()
    Wait(1000)
    if not weatherReady() then return end
    exports['rsg-weather']:setWeatherPattern(XmasPattern)
    exports['rsg-weather']:setWeather('snowlight', 10.0, false, true)
end)

AddEventHandler('onResourceStop', function(res)
    if res ~= GetCurrentResourceName() or GetResourceState('rsg-weather') ~= 'started' then return end
    exports['rsg-weather']:resetWeatherPattern()
    exports['rsg-weather']:resetWeather()
end)
