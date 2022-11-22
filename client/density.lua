-- controlls npc/traffic/animals (float from 0.0 (disabled) to 1.0)
Citizen.CreateThread(function()
	while true do
		Wait(0)
		---------------------------------------------------------------------------------------------
		--Citizen.InvokeNative(0xC0258742B034DFAF, 0.9)	-- SetAmbientAnimalDensityMultiplierThisFrame
		--Citizen.InvokeNative(0xDB48E99F8E064E56, 0.9)	-- SetScenarioAnimalDensityMultiplierThisFrame
		---------------------------------------------------------------------------------------------
	    --Citizen.InvokeNative(0xBA0980B5C0A11924, 0.9)	-- SetAmbientHumanDensityMultiplierThisFrame
		--Citizen.InvokeNative(0x28CB6391ACEDD9DB, 0.9)	-- SetScenarioHumanDensityMultiplierThisFrame
		---------------------------------------------------------------------------------------------
	    --Citizen.InvokeNative(0xAB0D553FE20A6E25, 0.9)	-- SetAmbientPedDensityMultiplierThisFrame
		--Citizen.InvokeNative(0x7A556143A1C03898, 0.9)	-- SetScenarioPedDensityMultiplierThisFrame
		---------------------------------------------------------------------------------------------
		Citizen.InvokeNative(0xFEDFA97638D61D4A, 0.0)	-- SetParkedVehicleDensityMultiplierThisFrame
		Citizen.InvokeNative(0x1F91D44490E1EA0C, 0.0)	-- SetRandomVehicleDensityMultiplierThisFrame
		Citizen.InvokeNative(0x606374EBFC27B133, 0.0)	-- SetVehicleDensityMultiplierThisFrame
		---------------------------------------------------------------------------------------------
	end
end)
