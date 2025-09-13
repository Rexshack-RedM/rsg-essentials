local bandana = false

RegisterNetEvent('rsg-bandana:client:ToggleBandana')
AddEventHandler('rsg-bandana:client:ToggleBandana', function()
    local male = IsPedMale(cache.ped)
    local neckwear = exports['rsg-appearance']:GetClothesCurrentComponentHash('neckwear')
    local applybeard = exports['rsg-appearance']:GetComponentId('beard').hash

    if not bandana then
        if not male then
            StartTaskItemInteraction(cache.ped, `KIT_BANDANA`, `BANDANA_ON_RIGHT_HAND`, 1, 0, -1082130432)
            Wait(700)
            ApplyShopItemToPed(cache.ped, 0xC615A086, true, true, true)
            UpdatePedVariation(cache.ped, 0, 1, 1, 1, false)

            bandana = true

            return
        end

        StartTaskItemInteraction(cache.ped, `KIT_BANDANA`, `BANDANA_ON_RIGHT_HAND`, 1, 0, -1082130432)
        Wait(700)
        EquipMetaPedOutfit(cache.ped, -1100875244)
        UpdatePedVariation(cache.ped, 0, 1, 1, 1, false)

        bandana = true

        return
    end

    if not male then
        StartTaskItemInteraction(cache.ped, `KIT_BANDANA`, `BANDANA_OFF_RIGHT_HAND`, 1, 0, -1082130432)
        Wait(700)
        RemoveTagFromMetaPed(cache.ped, 0x5FC29285, 0)
        Wait(100)
        ApplyShopItemToPed(cache.ped, neckwear, true, true, true)
        UpdatePedVariation(cache.ped, 0, 1, 1, 1, false)

        bandana = false

        return
    end

    StartTaskItemInteraction(cache.ped, `KIT_BANDANA`, `BANDANA_OFF_RIGHT_HAND`, 1, 0, -1082130432)
    Wait(700)
    RemoveTagFromMetaPed(cache.ped, 0x5FC29285, 0)
    Wait(100)
    RemoveTagFromMetaPed(cache.ped, 0xF8016BCA, 0)
    ApplyShopItemToPed(cache.ped, applybeard, true, true, true)
    UpdatePedVariation(cache.ped, 0, 1, 1, 1, false)

    bandana = false
end)