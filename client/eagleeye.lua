function EnableEagleeye(player, enable)
    Citizen.InvokeNative(0xA63FCAD3A6FEC6D2, player, enable)
end

AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    if Config.EnableEagleEye then
        EnableEagleeye(PlayerId(), true)
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    EnableEagleeye(PlayerId(), false)
end)
