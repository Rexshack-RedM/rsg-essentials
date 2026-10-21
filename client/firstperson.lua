local forced = false

-- forces first person while free-aiming; thread exits entirely when disabled in config
CreateThread(function()
    if not Config.FirstPersonShooting then return end
    local playerId = PlayerId()
    while true do
        if IsPlayerFreeAiming(playerId) then
            Citizen.InvokeNative(0x90DA5BA5C2635416) -- force first person cam this frame
            forced = true
            Wait(0)
        else
            if forced then
                Citizen.InvokeNative(0x1CFB749AD4317BDE)
                forced = false
            end
            Wait(100) -- idle while not aiming (was every frame)
        end
    end
end)
