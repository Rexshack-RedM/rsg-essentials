-- ped drown / boat sink fix
Citizen.CreateThread(function()
	while true do
		Wait(0)
		Citizen.InvokeNative(0xC1E8A365BF3B29F2, PlayerPedId(), 364)   -- PRF_IgnoreDrownAndKillVolumes
	end
end)
