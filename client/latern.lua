-- re-holsters the lantern on the hip when the player switches away from it
local LANTERNS = {
    [-164645981] = { name = 'WEAPON_MELEE_LANTERN',           dummy = 'WEAPON_MELEE_LANTERN_HALLOWEEN' },
    [1527076334] = { name = 'WEAPON_MELEE_LANTERN_HALLOWEEN', dummy = 'WEAPON_MELEE_DAVY_LANTERN' },
    [1247405313] = { name = 'WEAPON_MELEE_DAVY_LANTERN',      dummy = 'WEAPON_MELEE_LANTERN_HALLOWEEN' },
}
local ADD_REASON = joaat('ADD_REASON_DEFAULT')

local function giveWeapon(ped, name, attachPoint)
    local hash = joaat(name)
    Citizen.InvokeNative(0x72D4CB5DB927009C, hash, 0, true) -- REQUEST_WEAPON_ASSET
    Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, hash, 100, true, false, attachPoint, true, 0.0, 0.0, ADD_REASON, true, 0.0, false) -- GIVE_WEAPON_TO_PED
end

local function removeWeapon(ped, name)
    Citizen.InvokeNative(0x4899CB088EDF59B8, ped, joaat(name), true, ADD_REASON) -- REMOVE_WEAPON_FROM_PED
end

CreateThread(function()
    local lastLantern
    while true do
        Wait(250)
        local ped = PlayerPedId()
        local held = Citizen.InvokeNative(0x8425C5F057012DAB, ped) -- GET_PED_CURRENT_HELD_WEAPON
        if LANTERNS[held] then
            lastLantern = LANTERNS[held]
        elseif lastLantern then
            giveWeapon(ped, lastLantern.name, 12)  -- attach to hip
            giveWeapon(ped, lastLantern.dummy, 0)  -- refresh attachment
            removeWeapon(ped, lastLantern.dummy)
            lastLantern = nil
        end
    end
end)
