function givePlayerWeapon(weaponName, attachPoint)
    local addReason = joaat("ADD_REASON_DEFAULT")
    local weaponHash = joaat(weaponName)
    local ammoCount = 100
    Citizen.InvokeNative(0x72D4CB5DB927009C, weaponHash, 0, true)
    Citizen.InvokeNative(0x5E3BDDBCB83F3D84, cache.ped, weaponHash, ammoCount, true, false, attachPoint, true, 0.0, 0.0, addReason, true, 0.0, false)
end

function RemoveWeapon(weaponName)
    local addReason = joaat("ADD_REASON_DEFAULT")
    local weaponHash = joaat(weaponName)
    Citizen.InvokeNative(0x4899CB088EDF59B8, cache.ped, weaponHash, true, addReason)
end

local lantern = false
local halloweenlantern = false
local davylantern = false

CreateThread(function()
    while true do
        Wait(100)
        local heldweapon = Citizen.InvokeNative(0x8425C5F057012DAB, cache.ped)

        if heldweapon == -164645981 then
            lantern = true
        elseif heldweapon == 1527076334 then
            halloweenlantern = true
        elseif heldweapon == 1247405313 then
            davylantern = true
        end

        if lantern then
            if heldweapon ~= -164645981 then
                givePlayerWeapon("WEAPON_MELEE_LANTERN", 12)
                givePlayerWeapon("WEAPON_MELEE_LANTERN_HALLOWEEN", 0)
                RemoveWeapon("WEAPON_MELEE_LANTERN_HALLOWEEN")
                lantern = false
            end
        elseif lantern then
            lantern = false
            givePlayerWeapon("WEAPON_MELEE_LANTERN", 0)
            RemoveWeapon("WEAPON_MELEE_LANTERN")
        end

        if halloweenlantern then
            if heldweapon ~= 1527076334 then
                givePlayerWeapon("WEAPON_MELEE_LANTERN_HALLOWEEN", 12)
                givePlayerWeapon("WEAPON_MELEE_DAVY_LANTERN", 0)
                RemoveWeapon("WEAPON_MELEE_DAVY_LANTERN")
                halloweenlantern = false
            end
        elseif halloweenlantern then
            halloweenlantern = false
            givePlayerWeapon("WEAPON_MELEE_LANTERN_HALLOWEEN", 0)
            RemoveWeapon("WEAPON_MELEE_LANTERN_HALLOWEEN")
        end

        if davylantern then
            if heldweapon ~= 1247405313 then
                givePlayerWeapon("WEAPON_MELEE_DAVY_LANTERN", 12)
                givePlayerWeapon("WEAPON_MELEE_LANTERN_HALLOWEEN", 0)
                RemoveWeapon("WEAPON_MELEE_LANTERN_HALLOWEEN")
                davylantern = false
            end
        elseif davylantern then
            davylantern = false
            givePlayerWeapon("WEAPON_MELEE_DAVY_LANTERN", 0)
            RemoveWeapon("WEAPON_MELEE_DAVY_LANTERN")
        end
    end
end)
