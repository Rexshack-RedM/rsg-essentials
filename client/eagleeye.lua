local RSGCore = exports['rsg-core']:GetCoreObject()

local function setEagleEye(enable)
    Citizen.InvokeNative(0xA63FCAD3A6FEC6D2, PlayerId(), enable) -- _ENABLE_EAGLEEYE
    if Config.Debug then print(enable and 'Eagle Eye Enabled' or 'Eagle Eye Disabled') end
end

local function canUseEagleEye(job)
    if Config.EagleEye.everyone.enabled then return true end
    local cfg = job and Config.EagleEye[job]
    return cfg and cfg.enabled or false
end

local function refresh(job)
    if not job then
        local data = RSGCore.Functions.GetPlayerData()
        job = data and data.job and data.job.name
    end
    setEagleEye(canUseEagleEye(job))
end

AddEventHandler('RSGCore:Client:OnPlayerLoaded', function() refresh() end)
RegisterNetEvent('RSGCore:Client:OnJobUpdate', function(job) refresh(job and job.name) end)

AddEventHandler('onResourceStart', function(res)
    if res == GetCurrentResourceName() and LocalPlayer.state.isLoggedIn then refresh() end
end)

AddEventHandler('onResourceStop', function(res)
    if res == GetCurrentResourceName() then setEagleEye(false) end
end)
