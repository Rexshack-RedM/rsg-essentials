-- controls npc/traffic/animals (float from 0.0 to 1.0) / adjust as required
-- Can be edited in the config.lua

Citizen.CreateThread(function()
    -- "ThisFrame" natives must run every frame; config values are read once into locals
    local d = Config.Density
    local d1, d2, d3, d4, d5, d6, d7, d8, d9 = d[1], d[2], d[3], d[4], d[5], d[6], d[7], d[8], d[9]
    local Invoke = Citizen.InvokeNative
    while true do
        Wait(0)
        Invoke(0xC0258742B034DFAF, d1)    -- SetAmbientAnimalDensityMultiplierThisFrame
        Invoke(0xDB48E99F8E064E56, d2)    -- SetScenarioAnimalDensityMultiplierThisFrame
        Invoke(0xBA0980B5C0A11924, d3)    -- SetAmbientHumanDensityMultiplierThisFrame
        Invoke(0x28CB6391ACEDD9DB, d4)    -- SetScenarioHumanDensityMultiplierThisFrame
        Invoke(0xAB0D553FE20A6E25, d5)    -- SetAmbientPedDensityMultiplierThisFrame
        Invoke(0x7A556143A1C03898, d6)    -- SetScenarioPedDensityMultiplierThisFrame
        Invoke(0xFEDFA97638D61D4A, d7)    -- SetParkedVehicleDensityMultiplierThisFrame
        Invoke(0x1F91D44490E1EA0C, d8)    -- SetRandomVehicleDensityMultiplierThisFrame
        Invoke(0x606374EBFC27B133, d9)    -- SetVehicleDensityMultiplierThisFrame
    end
end)