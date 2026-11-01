local RSGCore = exports['rsg-core']:GetCoreObject()
local animDict, animName = 'script_proc@robberies@homestead@lonnies_shack@deception', 'hands_up_loop'
local handsUp = false

local function lower(ped)
    ClearPedSecondaryTask(ped)
    LocalPlayer.state:set('inv_busy', false, true)
    handsUp = false
end

CreateThread(function()
    local keybind = RSGCore.Shared.Keybinds['X']
    while true do
        Wait(0) -- IsControlJustPressed is only true for one frame
        if IsControlJustPressed(0, keybind) then
            local ped = PlayerPedId()
            local pd = RSGCore.Functions.GetPlayerData()
            local meta = pd and pd.metadata or {}
            if IsEntityPlayingAnim(ped, animDict, animName, 3) then
                lower(ped)
            elseif not meta.isdead and not meta.ishandcuffed and not IsEntityDead(ped)
                and not Citizen.InvokeNative(0x9682F850056C9ADE, ped) then -- IS_PED_CUFFED
                SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
                RequestAnimDict(animDict)
                local timeout = GetGameTimer() + 3000
                while not HasAnimDictLoaded(animDict) and GetGameTimer() < timeout do Wait(0) end
                if HasAnimDictLoaded(animDict) then
                    TaskPlayAnim(ped, animDict, animName, 2.0, -2.0, -1, 67109393, 0.0, false, 1245184, false, 'UpperbodyFixup_filter', false)
                    LocalPlayer.state:set('inv_busy', true, true)
                    handsUp = true
                end
            end
        end
    end
end)

AddEventHandler('onResourceStop', function(res)
    if res == GetCurrentResourceName() and handsUp then lower(PlayerPedId()) end
end)
