-- controlls npc/traffic/animals (float from 0.0 to 1.0)
Citizen.CreateThread(function()
	while true do
		Wait(0)
		---------------------------------------------------------------------------------------------
		--Citizen.InvokeNative(0xC0258742B034DFAF, 0.1)	-- SetAmbientAnimalDensityMultiplierThisFrame
		--Citizen.InvokeNative(0xDB48E99F8E064E56, 0.1)	-- SetScenarioAnimalDensityMultiplierThisFrame
		---------------------------------------------------------------------------------------------
		Citizen.InvokeNative(0xBA0980B5C0A11924, 0.9)	-- SetAmbientHumanDensityMultiplierThisFrame
		Citizen.InvokeNative(0x28CB6391ACEDD9DB, 0.9)	-- SetScenarioHumanDensityMultiplierThisFrame
		---------------------------------------------------------------------------------------------
		Citizen.InvokeNative(0xAB0D553FE20A6E25, 0.9)	-- SetAmbientPedDensityMultiplierThisFrame
		Citizen.InvokeNative(0x7A556143A1C03898, 0.9)	-- SetScenarioPedDensityMultiplierThisFrame
		---------------------------------------------------------------------------------------------
		Citizen.InvokeNative(0xFEDFA97638D61D4A, 0.1)	-- SetParkedVehicleDensityMultiplierThisFrame
		Citizen.InvokeNative(0x1F91D44490E1EA0C, 0.1)	-- SetRandomVehicleDensityMultiplierThisFrame
		Citizen.InvokeNative(0x606374EBFC27B133, 0.1)	-- SetVehicleDensityMultiplierThisFrame
		---------------------------------------------------------------------------------------------
	end
end)

-- wagon stuck fix from https://github.com/BryceCanyonCounty/bcc-vehiclefixes
Citizen.CreateThread(function()
	local vehiclePool = {}
	local wagon = 0
	local driver = 0
	local horse = 0
	while true do
		vehiclePool = GetGamePool('CVehicle') -- Get the list of vehicles (entities) from the pool
		for i = 1, #vehiclePool do -- loop through each vehicle (entity)
			wagon = vehiclePool[i]
			-- Is wagon stopped
			if IsEntityAVehicle(wagon) and IsVehicleStopped(wagon) then
				-- Get the horse
				horse = Citizen.InvokeNative(0xA8BA0BAE0173457B, wagon, 0)
				-- If vehicle stopped but the horse walks = buggy wagon
				if IsPedWalking(horse) then
					-- Delete driver & wagon
					driver = Citizen.InvokeNative(0x2963B5C1637E8A27, wagon)
					if driver ~= PlayerPedId() then -- Ensure the driver is not a player
						if driver then
							DeleteEntity(driver) -- Delete driver from wagon if there is one
						end
						DeleteEntity(wagon) -- Delete buggy wagon
					end
				end
			end
		end
		Citizen.Wait(1000)
	end
end)
