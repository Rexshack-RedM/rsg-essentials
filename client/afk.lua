local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()
local isLoggedIn = LocalPlayer.state.isLoggedIn
local ignoredGroups = {
    ['mod'] = true,
    ['admin'] = true,
    ['god'] = true
}
local secondsUntilKick = 1800 -- AFK Kick Time Limit (in seconds)
local checkUser = true
local prevPos, time = nil, nil
local timeMinutes = {
    ['900'] = 'minutes',
    ['600'] = 'minutes',
    ['300'] = 'minutes',
    ['150'] = 'minutes',
    ['60'] = 'minutes',
    ['30'] = 'seconds',
    ['20'] = 'seconds',
    ['10'] = 'seconds',
}

local function updatePermissionLevel()
    RSGCore.Functions.TriggerCallback('rsg-afkkick:server:GetPermissions', function(userGroups)
        for k in pairs(userGroups) do
            if ignoredGroups[k] then
                checkUser = false
                break
            end
            checkUser = true
        end
    end)
end

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    updatePermissionLevel()
    isLoggedIn = true
end)

RegisterNetEvent('RSGCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('RSGCore:Client:OnPermissionUpdate', function()
    updatePermissionLevel()
end)

CreateThread(function()
    while true do
        Wait(1000)
        local playerPed = PlayerPedId()
        if isLoggedIn then
            if checkUser then
                local currentPos = GetEntityCoords(playerPed, true)
                if prevPos then
                    if currentPos == prevPos then
                        if time then
                            if time > 0 then
                                local _type = timeMinutes[tostring(time)]
                                if _type == 'minutes' then
                                    lib.notify({ title = locale('cl_will_kick'), description = math.ceil(time / 60) .. locale('cl_time_seconds'), type = 'error', duration = 5000 })
                                elseif _type == 'seconds' then
                                    lib.notify({ title = locale('cl_will_kick'), description = time .. locale('cl_time_seconds'), type = 'error', duration = 5000 })
                                end
                                time -= 1
                            else
                                TriggerServerEvent('KickForAFK')
                            end
                        else
                            time = secondsUntilKick
                        end
                    else
                        time = secondsUntilKick
                    end
                end
                prevPos = currentPos
            end
        end
    end
end)