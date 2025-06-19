local RSGCore = exports['rsg-core']:GetCoreObject()

local function CheckGuarmaSpawn()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local area = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 10)
    
    if area == -512529193 then
        Citizen.InvokeNative(0xA657EC9DBC6CC900, 1935063277)
        Citizen.InvokeNative(0xE8770EE02AEE45C2, 1)
        Citizen.InvokeNative(0x74E2261D2A66849A, true)
    end
end

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    SetTimeout(5000, function()
        CheckGuarmaSpawn()
    end)
end)
