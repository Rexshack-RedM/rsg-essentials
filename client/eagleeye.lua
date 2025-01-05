local RSGCore = exports['rsg-core']:GetCoreObject()


function EnableEagleeye(player, enable)
    Citizen.InvokeNative(0xA63FCAD3A6FEC6D2, player, enable)
    print(enable and "Eagle Eye Enabled" or "Eagle Eye Disabled")
end


function ShouldEnableEagleEye(job)
    if Config.EagleEye.everyone.enabled then
        return true
    end

    if Config.EagleEye[job] and Config.EagleEye[job].enabled then
        return true
    end

    return false
end

function HandleEagleEyeAccess()
    local playerJob = RSGCore.Functions.GetPlayerData().job.name
    if ShouldEnableEagleEye(playerJob) then
        EnableEagleeye(PlayerId(), true)
    else
        EnableEagleeye(PlayerId(), false)
    end
end


AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    HandleEagleEyeAccess()
end)


RegisterNetEvent('RSGCore:Client:OnJobUpdate')
AddEventHandler('RSGCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    HandleEagleEyeAccess()
end)


AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    HandleEagleEyeAccess() 
end)

-- Event handler for when the resource stops
AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    EnableEagleeye(PlayerId(), false)
end)
