-- map zone colours : credit to Viyu88 https://github.com/Viyu88/viyu_colormap
CreateThread(function()
    for i = 1, #Config.Zones do
        local zone = Config.Zones[i]
        Citizen.InvokeNative(0x563FCB6620523917, zone.Hash, joaat(zone.Color)) -- _MAP_ENABLE_REGION_BLIP
    end
end)
