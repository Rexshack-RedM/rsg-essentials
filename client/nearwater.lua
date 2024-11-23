local RSGCore = exports['rsg-core']:GetCoreObject()
local WashPromp
local DrinkPromp
local RiverGroup = GetRandomIntInRange(0, 0xffffff)
lib.locale()

-- set wash prompt
function WashPrompt()
    Citizen.CreateThread(function()
        local str = locale('cl_wash')
        local wait = 0
        WashPromp = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(WashPromp, RSGCore.Shared.Keybinds['ENTER'])
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(WashPromp, str)
        PromptSetEnabled(WashPromp, true)
        PromptSetVisible(WashPromp, true)
        PromptSetHoldMode(WashPromp, true)
        PromptSetGroup(WashPromp, RiverGroup)
        PromptRegisterEnd(WashPromp)
    end)
end

-- set drink prompt
function DrinkPrompt()
    Citizen.CreateThread(function()
        local str =locale('cl_drink')
        local wait = 0
        DrinkPromp = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(DrinkPromp, RSGCore.Shared.Keybinds['J'])
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(DrinkPromp, str)
        PromptSetEnabled(DrinkPromp, true)
        PromptSetVisible(DrinkPromp, true)
        PromptSetHoldMode(DrinkPromp, true)
        PromptSetGroup(DrinkPromp, RiverGroup)
        PromptRegisterEnd(DrinkPromp)
    end)
end

CreateThread(function()
    WashPrompt()
    DrinkPrompt()

    while true do
        Wait(4)

        local weapon = Citizen.InvokeNative(0x8425C5F057012DAB, cache.ped)
        local weaponName = Citizen.InvokeNative(0x89CF5FF3D363311E, weapon, Citizen.ResultAsString())
        local coords = GetEntityCoords(cache.ped)
        local water = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x+3, coords.y+3, coords.z)
        local running = IsControlPressed(0, 0x8FFC75D6) or IsDisabledControlPressed(0, 0x8FFC75D6)

        if running or weaponName == "WEAPON_FISHINGROD" then goto continue end

        for k,v in pairs(Config.WaterTypes) do
            if water == Config.WaterTypes[k]["waterhash"] then
                if IsPedOnFoot(cache.ped) then
                    if IsEntityInWater(cache.ped) then
                        -- wash
                        local Wash = CreateVarString(10, 'LITERAL_STRING', Config.WaterTypes[k]["name"])
                        PromptSetActiveGroupThisFrame(RiverGroup, Wash)

                        if PromptHasHoldModeCompleted(WashPrompt) then
                            StartWash("amb_misc@world_human_wash_face_bucket@ground@male_a@idle_d", "idle_l")
                        end
                        -- drink
                        local drink = CreateVarString(10, 'LITERAL_STRING', Config.WaterTypes[k]["name"])
                        PromptSetActiveGroupThisFrame(RiverGroup, drink)

                        if PromptHasHoldModeCompleted(DrinkPrompt) then
                            TriggerEvent('rsg-river:client:drink')
                        end
                    end
                end
            end
        end
        ::continue::
    end
end)

-- drink action
AddEventHandler('rsg-river:client:drink', function()
    local src = source
    if drink ~= 0 then
        SetEntityAsMissionEntity(drink)
        DeleteObject(nativerioprop)
        drink = 0
    end

    Wait(0)
    if IsPedMale(cache.ped) then
        TaskStartScenarioInPlace(cache.ped, GetHashKey('WORLD_HUMAN_BUCKET_DRINK_GROUND'), -1, true, false, false, false)
    else
        TaskStartScenarioInPlace(cache.ped, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
    end
    Wait(17000)
    TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] + math.random(50, 100))
    ClearPedTasks(cache.ped)
end)

---Wash face animation
AddEventHandler('rsg-river:client:lavati', function()
    local src = source
    StartWash("amb_misc@world_human_wash_face_bucket@ground@male_a@idle_d", "idle_l")
end)

-- wash action
StartWash = function(dic, anim)
    LoadAnim(dic)
    TaskPlayAnim(cache.ped, dic, anim, 1.0, 8.0, 5000, 0, 0.0, false, false, false)
    Wait(5000)
    ClearPedTasks(cache.ped)
    ClearPedEnvDirt(cache.ped)
    ClearPedBloodDamage(cache.ped)
    SetPedDirtCleaned(cache.ped, 0.0, -1, 1, 1)
    ClearPedDamageDecalByZone(cache.ped, 10, "ALL")
    ClearPedBloodDamageFacial(cache.ped, 1)
    TriggerServerEvent("RSGCore:Server:SetMetaData", "cleanliness", 100)
end

LoadAnim = function(dic)
    RequestAnimDict(dic)
    while not (HasAnimDictLoaded(dic)) do
        Wait(0)
    end
end

function whenKeyJustPressed(key)
    if IsControlJustPressed(0, key) then
        return true
    else
        return false
    end
end

-- debug water hash
CreateThread(function()
    while true do
        Wait(1)
        local coords = GetEntityCoords(cache.ped)
        local water = GetWaterMapZoneAtCoords(coords.x+3, coords.y+3, coords.z)
        if Config.Debug == true then
            print("water: "..tostring(water))
            Wait(5000)
        end
    end
end)
