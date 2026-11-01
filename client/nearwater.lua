local RSGCore = exports['rsg-core']:GetCoreObject()
local RiverGroup = GetRandomIntInRange(0, 0xffffff)
local WashPrompt, DrinkPrompt
local busy = false

-- water hash -> name lookup (built once)
local WaterNames = {}
for _, v in pairs(Config.WaterTypes) do WaterNames[v.waterhash] = v.name end

local function createPrompt(label, key)
    local prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, RSGCore.Shared.Keybinds[key])
    PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', label))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, true)
    PromptSetGroup(prompt, RiverGroup)
    PromptRegisterEnd(prompt)
    return prompt
end

local function wash()
    local ped = PlayerPedId()
    local dict = 'amb_misc@world_human_wash_face_bucket@ground@male_a@idle_d'
    RequestAnimDict(dict)
    local timeout = GetGameTimer() + 3000
    while not HasAnimDictLoaded(dict) and GetGameTimer() < timeout do Wait(0) end
    TaskPlayAnim(ped, dict, 'idle_l', 1.0, 8.0, Config.River.WashDuration, 0, 0.0, false, false, false)
    Wait(Config.River.WashDuration)
    ClearPedTasks(ped)
    ClearPedEnvDirt(ped)
    ClearPedBloodDamage(ped)
    SetPedDirtCleaned(ped, 0.0, -1, 1, 1)
    ClearPedDamageDecalByZone(ped, 10, 'ALL')
    ClearPedBloodDamageFacial(ped, 1)
    RemoveAnimDict(dict)
    TriggerEvent('hud:client:UpdateCleanliness', 100)
end

local function drink()
    local ped = PlayerPedId()
    local scenario = IsPedMale(ped) and `WORLD_HUMAN_BUCKET_DRINK_GROUND` or `WORLD_HUMAN_CROUCH_INSPECT`
    TaskStartScenarioInPlace(ped, scenario, -1, true, false, false, false)
    Wait(Config.River.DrinkDuration)
    local amount = math.random(Config.River.DrinkThirst.min, Config.River.DrinkThirst.max)
    TriggerEvent('hud:client:UpdateThirst', math.max(0, math.min(100, (LocalPlayer.state.thirst or 0) + amount)))
    ClearPedTasks(ped)
end

local function run(action)
    busy = true
    action()
    busy = false
end

CreateThread(function()
    WashPrompt = createPrompt(locale('cl_wash'), 'ENTER')
    DrinkPrompt = createPrompt(locale('cl_drink'), 'J')

    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        if not busy and IsPedStill(ped) and IsPedOnFoot(ped) and IsEntityInWater(ped)
            and (not Config.Crouch or GetPedCrouchMovement(ped) ~= 0)
            and GetPedCurrentHeldWeapon(ped) ~= `WEAPON_FISHINGROD` then
            local coords = GetEntityCoords(ped)
            local water = Citizen.InvokeNative(0x5BA7A68A346A5A91, coords.x + 3, coords.y + 3, coords.z) -- GET_WATER_MAP_ZONE_AT_COORDS
            local name = water and WaterNames[water]
            if name then
                sleep = 0
                PromptSetActiveGroupThisFrame(RiverGroup, CreateVarString(10, 'LITERAL_STRING', name))
                if PromptHasHoldModeCompleted(WashPrompt) then
                    run(wash)
                elseif PromptHasHoldModeCompleted(DrinkPrompt) then
                    run(drink)
                end
            elseif Config.Debug then
                print('water: ' .. tostring(water))
            end
        end
        Wait(sleep)
    end
end)

AddEventHandler('onResourceStop', function(res)
    if res ~= GetCurrentResourceName() then return end
    if WashPrompt then PromptDelete(WashPrompt) end
    if DrinkPrompt then PromptDelete(DrinkPrompt) end
end)
