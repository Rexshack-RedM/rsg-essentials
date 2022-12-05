-- controlls npc/traffic/animals (float from 0.0 to 1.0) / adjust as required
Citizen.CreateThread(function()
    while true do
        Wait(0)
        ---------------------------------------------------------------------------------------------
        Citizen.InvokeNative(0xC0258742B034DFAF, 1.0)    -- SetAmbientAnimalDensityMultiplierThisFrame
        Citizen.InvokeNative(0xDB48E99F8E064E56, 1.0)    -- SetScenarioAnimalDensityMultiplierThisFrame
        ---------------------------------------------------------------------------------------------
        Citizen.InvokeNative(0xBA0980B5C0A11924, 1.0)    -- SetAmbientHumanDensityMultiplierThisFrame
        Citizen.InvokeNative(0x28CB6391ACEDD9DB, 1.0)    -- SetScenarioHumanDensityMultiplierThisFrame
        ---------------------------------------------------------------------------------------------
        Citizen.InvokeNative(0xAB0D553FE20A6E25, 1.0)    -- SetAmbientPedDensityMultiplierThisFrame
        Citizen.InvokeNative(0x7A556143A1C03898, 1.0)    -- SetScenarioPedDensityMultiplierThisFrame
        ---------------------------------------------------------------------------------------------
        Citizen.InvokeNative(0xFEDFA97638D61D4A, 1.0)    -- SetParkedVehicleDensityMultiplierThisFrame
        Citizen.InvokeNative(0x1F91D44490E1EA0C, 1.0)    -- SetRandomVehicleDensityMultiplierThisFrame
        Citizen.InvokeNative(0x606374EBFC27B133, 1.0)    -- SetVehicleDensityMultiplierThisFrame
        ---------------------------------------------------------------------------------------------
    end
end)
