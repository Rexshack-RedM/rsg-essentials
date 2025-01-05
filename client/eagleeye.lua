local RSGCore = exports['rsg-core']:GetCoreObject()

function EnableEagleeye(player, enable)
    Citizen.InvokeNative(0xA63FCAD3A6FEC6D2, player, enable)
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


AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    local playerJob = RSGCore.Functions.GetPlayerData().job.name 
    print("Player Job: " .. playerJob) 
    if ShouldEnableEagleEye(playerJob) then
        EnableEagleeye(PlayerId(), true)
    else
        EnableEagleeye(PlayerId(), false)
    end
end)


AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    EnableEagleeye(PlayerId(), false)
end)
