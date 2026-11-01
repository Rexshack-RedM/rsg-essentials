local RSGCore = exports['rsg-core']:GetCoreObject()

local isLoggedIn = LocalPlayer.state.isLoggedIn
local checkUser = true
local warnAt = {}
for _, s in ipairs(Config.AFK.WarnAt) do warnAt[s] = true end

local function updatePermissionLevel()
    RSGCore.Functions.TriggerCallback('rsg-essentials:server:getPermissions', function(groups)
        checkUser = true
        for group in pairs(groups or {}) do
            if Config.AFK.IgnoredGroups[group] then
                checkUser = false
                break
            end
        end
    end)
end

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    updatePermissionLevel()
end)

RegisterNetEvent('RSGCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('RSGCore:Client:OnPermissionUpdate', updatePermissionLevel)

CreateThread(function()
    if not Config.AFK.Enabled then return end
    if isLoggedIn then updatePermissionLevel() end -- resource restart while logged in

    local prevPos, timeLeft
    while true do
        Wait(1000)
        if isLoggedIn and checkUser then
            local pos = GetEntityCoords(PlayerPedId())
            if prevPos and #(pos - prevPos) < 0.05 then
                timeLeft = (timeLeft or Config.AFK.KickAfter) - 1
                if timeLeft <= 0 then
                    TriggerServerEvent('rsg-essentials:server:afkKick')
                    timeLeft = Config.AFK.KickAfter
                elseif warnAt[timeLeft] then
                    local desc = timeLeft >= 60
                        and locale('cl_afk_minutes', math.ceil(timeLeft / 60))
                        or locale('cl_afk_seconds', timeLeft)
                    RSGCore.Functions.Notify({ id = 'rsg_afk', title = locale('cl_afk_title'), description = desc, type = 'warning', icon = 'fa-solid fa-hourglass-half', duration = 5000 })
                end
            else
                timeLeft = nil
            end
            prevPos = pos
        else
            prevPos, timeLeft = nil, nil
        end
    end
end)
