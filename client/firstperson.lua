local forced = false

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if IsPlayerFreeAiming(PlayerId()) and Config.FirstPersonShooting then
            firstperson = Citizen.InvokeNative(0x90DA5BA5C2635416)
            if firstperson == true and forced == false then
                forced = false
            else
                Citizen.InvokeNative(0x90DA5BA5C2635416)
                forced = true
            end
        else
            if forced == true then
                Citizen.InvokeNative(0x1CFB749AD4317BDE)
                forced = false
            end
        end
    end
end)
