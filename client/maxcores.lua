-- fills the health and stamina cores once the character is loaded
local function upgradeCore(upgrade)
    -- two 96 byte scratch buffers required by the native
    local a, b = string.rep('\0', 96), string.rep('\0', 96)
    Citizen.InvokeNative(0xCB5D11F9508A928D, 1, a, b, joaat(upgrade), 1084182731, 10, 752097756)
end

local function maxCores()
    upgradeCore('UPGRADE_HEALTH_TANK_1')
    upgradeCore('UPGRADE_STAMINA_TANK_1')
end

maxCores()
RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', maxCores)
