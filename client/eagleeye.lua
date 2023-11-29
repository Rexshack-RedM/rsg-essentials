function EnableEagleeye(player, enable)
    Citizen.InvokeNative(0xA63FCAD3A6FEC6D2, player, enable)
end

AddEventHandler('RSGCore:Client:OnPlayerLoaded', function()
    EnableEagleeye(PlayerId(), true)
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    EnableEagleeye(PlayerId(), false)
end)
