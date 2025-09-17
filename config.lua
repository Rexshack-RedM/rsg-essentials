Config = Config or {}

Config.Debug = false

-- enable first person shooting
Config.FirstPersonShooting = false

-- enable xmas weather
Config.EnableXmas = false

-- pause menu
Config.PauseReadBook = false

--Stop shuffle when entering wagons
Config.StopAutoShuffle = true

--can players fill the canteen from a water pump
Config.canteenPump = true

-- Determines whether crouching is required to interact with water bodies.
-- Set to `true` to force crouching, or `false` to allow interaction without crouching.
Config.Crouch = true

-- Configuration for enabling/disabling Eagle Eye based on player roles.
-- This allows server admins to control which roles (jobs) can use Eagle Eye.
Config.EagleEye = {
    -- Enable Eagle Eye for all players, regardless of their job.
    -- Set the everyone field to `false` to allow only job specific to use Eagle Eye.
    everyone = {
        enabled = true, -- Default: true (only specific jobs can use Eagle Eye on false)
    },
    vallaw = {
        enabled = false, 
    },
    rholaw = {
        enabled = false, 
    }
}

-- Go to Discord Developers Portal (https://discord.com/developers)

Config.Discord = {
    DiscordAppID = 12345678910111213,
    AppBigAssetID = 'big_img.png!',
    AppBigAssetText = 'big text img!',
    AppSmallAssetID = 'small_img.png',
    AppSmallAssetText = 'small text img!',
    FirstButtonPlaceholder = 'text enters the channel',
    FirstButtonLink = 'https://discord.gg/channel-id',
    SecondButtonPlaceholder = 'visit site text',
    SecondButtonLink = 'https://example.org',

    UpdateEvery = 60000, -- In ms. (60000ms = 1 minute)
    Template = 'ID: {ID} | Name: {NAME} | {PLAYERS_COUNT}' -- {NAME}, {ID}, {PLAYERS_COUNT}
}

-- discord webhook config
Config.DiscordWHImage = 'https://cdn.discordapp.com/attachments/1032260791669375006/1066811751389208596/rsg256x256.png'
Config.DiscordWHLogUserName = 'Rexshack Gaming Logs'
Config.DiscordWHAuthorName = 'Rexshack Gaming'

-- density config
Config.Density = {
    -- Ambient Animal Density
    [1] = 1.0,
    -- Scenario Animal Density
    [2] = 1.0,
    -- Ambient Human Density
    [3] = 1.0,
    -- Scenario Human Density
    [4] = 1.0,
    -- Ambient Ped Density
    [5] = 1.0,
    -- Scenario Ped Density
    [6] = 1.0,
    -- Parked Vehicle Density
    [7] = 0.0,
    -- Random Vehicle Density
    [8] = 0.0,
    -- Vehicle Density
    [9] = 0.0,
}

-- water types config
Config.WaterTypes = {
    [1] =  {["name"] = "Sea of Coronado",       ["waterhash"] = -247856387,     ["watertype"] = "sea"},
    [2] =  {["name"] = "San Luis River",        ["waterhash"] = -1504425495,    ["watertype"] = "river"},
    [3] =  {["name"] = "Lake Don Julio",        ["waterhash"] = -1369817450,    ["watertype"] = "lake"},
    [4] =  {["name"] = "Flat Iron Lake",        ["waterhash"] = -1356490953,    ["watertype"] = "lake"},
    [5] =  {["name"] = "Upper Montana River",   ["waterhash"] = -1781130443,    ["watertype"] = "river"},
    [6] =  {["name"] = "Owanjila",              ["waterhash"] = -1300497193,    ["watertype"] = "river"},
    [7] =  {["name"] = "HawkEye Creek",         ["waterhash"] = -1276586360,    ["watertype"] = "river"},
    [8] =  {["name"] = "Little Creek River",    ["waterhash"] = -1410384421,    ["watertype"] = "river"},
    [9] =  {["name"] = "Dakota River",          ["waterhash"] = 370072007,      ["watertype"] = "river"},
    [10] =  {["name"] = "Beartooth Beck",       ["waterhash"] = 650214731,      ["watertype"] = "river"},
    [11] =  {["name"] = "Lake Isabella",        ["waterhash"] = 592454541,      ["watertype"] = "lake"},
    [12] =  {["name"] = "Cattail Pond",         ["waterhash"] = -804804953,     ["watertype"] = "lake"},
    [13] =  {["name"] = "Deadboot Creek",       ["waterhash"] = 1245451421,     ["watertype"] = "river"},
    [14] =  {["name"] = "Spider Gorge",         ["waterhash"] = -218679770,     ["watertype"] = "river"},
    [15] =  {["name"] = "O'Creagh's Run",       ["waterhash"] = -1817904483,    ["watertype"] = "lake"},
    [16] =  {["name"] = "Moonstone Pond",       ["waterhash"] = -811730579,     ["watertype"] = "lake"},
    [17] =  {["name"] = "Roanoke Valley",       ["waterhash"] = -1229593481,    ["watertype"] = "river"},
    [18] =  {["name"] = "Elysian Pool",         ["waterhash"] = -105598602,     ["watertype"] = "lake"},
    [19] =  {["name"] = "Lannahechee River",    ["waterhash"] = -2040708515,    ["watertype"] = "river"},
    [20] =  {["name"] = "Random1",              ["waterhash"] = 231313522,      ["watertype"] = "river"},
    [21] =  {["name"] = "Random2",              ["waterhash"] = 2005774838,     ["watertype"] = "river"},
    [22] =  {["name"] = "Random3",              ["waterhash"] = -1287619521,    ["watertype"] = "river"},
    [23] =  {["name"] = "Random4",              ["waterhash"] = -1308233316,    ["watertype"] = "river"},
    [24] =  {["name"] = "Random5",              ["waterhash"] = -196675805,     ["watertype"] = "river"},
    [25] =  {["name"] = "Bahia De La Paz",      ["waterhash"] = -1168459546,    ["watertype"] = "sea"},
    [26] =  {["name"] = "Arroyo De La Vibora",  ["waterhash"] = -49694339,      ["watertype"] = "river"},
}

-- map zones
Config.Zones = {
--AMBARINO
    {Hash = 0x3B8DD21A, Color = 'BLIP_MODIFIER_MP_COLOR_1'}, --STATE_AMBARINO
    {Hash = 0x3BBA228A, Color = 'BLIP_MODIFIER_MP_COLOR_13'}, --LBS_AMBARINO_BOUNTY
    --{Hash = 0x9125D14C, Color = 'BLIP_MODIFIER_MP_COLOR_22'}, --DISTRICT_GRIZZLIES
    --{Hash = 0x943198D3, Color = 'BLIP_MODIFIER_MP_COLOR_1'}, --DISTRICT_GRIZZLIES_EAST
    --{Hash = 0xD41D039A, Color = 'BLIP_MODIFIER_MP_COLOR_21'}, --DISTRICT_GRIZZLIES_WEST
    --{Hash = 0xBB785C8A, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --REGION_GRZ_WAPITI
    --{Hash = 0x4F45BE43, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --OUTLINE_WAPITI

--LEMOYNE
    {Hash = 0x945395DF, Color = 'BLIP_MODIFIER_MP_COLOR_3'}, --STATE_LEMOYNE
    {Hash = 0x0F32B44D, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --LBS_LEMOYNE_BOUNTY
    --{Hash = 0x2843E325, Color = 'BLIP_MODIFIER_MP_COLOR_3'}, --DISTRICT_BAYOU_NWA
    --{Hash = 0x024C01CA, Color = 'BLIP_MODIFIER_MP_COLOR_14'}, --DISTRICT_BLUEGILL_MARSH
    --{Hash = 0x0BB92EEF, Color = 'BLIP_MODIFIER_MP_COLOR_22'}, --DISTRICT_SCARLETT_MEADOWS
    --{Hash = 0x9652B96E, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --REGION_BAY_LAGRAS
    --{Hash = 0x049BBBD4, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --OUTLINE_LAGRAS
    --{Hash = 0x2A6CBBA2, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --REGION_BAY_SAINT_DENIS
    --{Hash = 0xC354EAC2, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --OUTLINE_SAINT_DENIS
    --{Hash = 0x2D1A7AF2, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --REGION_BLU_SISIKA
    --{Hash = 0xFC531E7A, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --REGION_SCM_BRAITHWAITEMANOR
    --{Hash = 0x5E68036B, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --OUTLINE_BRAITHWAITEMANOR
    --{Hash = 0xD218D90D, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --REGION_SCM_CALIGAHALL
    --{Hash = 0xE074391B, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --OUTLINE_CALIGAHALL
    --{Hash = 0xD3F2B8A7, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --REGION_SCM_RHODES
    --{Hash = 0x09FAE063, Color = 'BLIP_MODIFIER_MP_COLOR_15'}, --OUTLINE_RHODES


--NEW AUSTIN
    {Hash = 0x41759831, Color = 'BLIP_MODIFIER_MP_COLOR_4'}, --STATE_NEW_AUSTIN
    {Hash = 0xD339F6AB, Color = 'BLIP_MODIFIER_MP_COLOR_16'}, --LBS_NEW_AUSTIN_BOUNTY
    --{Hash = 0x99B6A1E6, Color = 'BLIP_MODIFIER_MP_COLOR_4'}, --DISTRICT_CHOLLA_SPRINGS
    --{Hash = 0x3AC128F9, Color = 'BLIP_MODIFIER_MP_COLOR_30'}, --DISTRICT_GAPTOOTH_RIDGE
    --{Hash = 0x33D88587, Color = 'BLIP_MODIFIER_MP_COLOR_18'}, --DISTRICT_HENNIGANS_STEAD
    --{Hash = 0xD428627B, Color = 'BLIP_MODIFIER_MP_COLOR_29'}, --DISTRICT_RIO_BRAVO


--NEW HANOVER
    {Hash = 0x41332496, Color = 'BLIP_MODIFIER_MP_COLOR_8'}, --STATE_NEW_HANOVER
    {Hash = 0x5CD2A36F, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --LBS_NEW_HANOVER_BOUNTY

    --{Hash = 0x717F4A96, Color = 'BLIP_MODIFIER_MP_COLOR_11'}, --DISTRICT_CUMBERLAND_FOREST
    --{Hash = 0x724E7654, Color = 'BLIP_MODIFIER_MP_COLOR_8'}, --DISTRICT_HEARTLAND
    --{Hash = 0x30FAE29B, Color = 'BLIP_MODIFIER_MP_COLOR_19'}, --DISTRICT_ROANOKE_RIDGE
    --{Hash = 0x1BDD5A12, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --REGION_CML_OLDFORTWALLACE
    --{Hash = 0x2FE84F0E, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --OUTLINE_OLDFORTWALLACE
    --{Hash = 0x7B23B4C7, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --REGION_HRT_CORNWALLKEROSENE
    --{Hash = 0x150D72E9, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --OUTLINE_CORNWALLKEROSEN
    --{Hash = 0x6E7BDAC4, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --REGION_HRT_EMERALDRANCH
    --{Hash = 0x13A98173, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --OUTLINE_EMERALD
    --{Hash = 0x0079B7EE, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --REGION_HRT_VALENTINE
    --{Hash = 0x2A24C8D9, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --OUTLINE_VALENTINE
    --{Hash = 0x0A8B2CBE, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --REGION_ROA_ANNESBURG
    --{Hash = 0x9CC09C3D, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --OUTLINE_ANNESBURG
    --{Hash = 0xA053D058, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --REGION_ROA_BUTCHERCREEK
    --{Hash = 0xB6831F62, Color = 'BLIP_MODIFIER_MP_COLOR_20'}, --OUTLINE_BUTCHERCREEK
    --{Hash = 0x507B5360, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --REGION_ROA_VANHORNPOST
    --{Hash = 0x194E52AF, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --OUTLINE_VANHORNPOST

--WEST ELIZABETH
    {Hash = 0xD69B5B49, Color = 'BLIP_MODIFIER_MP_COLOR_6'}, --STATE_WEST_ELIZABETH
    {Hash = 0xF030C0B2, Color = 'BLIP_MODIFIER_MP_COLOR_23'}, --LBS_W_ELIZABETH_BOUNTY
    --{Hash = 0x8DCC574F, Color = 'BLIP_MODIFIER_MP_COLOR_6'}, --DISTRICT_BIG_VALLEY
    --{Hash = 0x0E95FF51, Color = 'BLIP_MODIFIER_MP_COLOR_28'}, --DISTRICT_GREAT_PLAINS
    --{Hash = 0x763A8A87, Color = 'BLIP_MODIFIER_MP_COLOR_31'}, --DISTRICT_TALL_TREES
    --{Hash = 0x4663EEB9, Color = 'BLIP_MODIFIER_MP_COLOR_23'}, --REGION_BGV_STRAWBERRY
    --{Hash = 0x3B4A5D5B, Color = 'BLIP_MODIFIER_MP_COLOR_23'}, --OUTLINE_STRAWBERRY
    --{Hash = 0x5647E155, Color = 'BLIP_MODIFIER_MP_COLOR_23'}, --REGION_GRT_BLACKWATER
    --{Hash = 0x129E1411, Color = 'BLIP_MODIFIER_MP_COLOR_23'}, --OUTLINE_BLACKWATER
    --{Hash = 0xDC87C0C8, Color = 'BLIP_MODIFIER_MP_COLOR_23'}, --REGION_TAL_MANZANITAPOST


--GUARMA
    --{Hash = 0x9307FD41, Color = 'BLIP_MODIFIER_MP_COLOR_7'}, --STATE_GUARMA
    --{Hash = 0x6009F334, Color = 'BLIP_MODIFIER_MP_COLOR_7'}, --LBS_GUARMA_BOUNTY

    --{Hash = 0x6E10D212, Color = 'BLIP_MODIFIER_MP_COLOR_7'}, --REGION_GUA_MANICATO


--NUEVO PARAÍSO
    --{Hash = 0x8966022D, Color = 'BLIP_MODIFIER_MP_COLOR_22'}, --DISTRICT_DIEZ_CORONAS
    --{Hash = 0x27253ED3, Color = 'BLIP_MODIFIER_MP_COLOR_22'}, --DISTRICT_PERDIDO
    --{Hash = 0x5046DD11, Color = 'BLIP_MODIFIER_MP_COLOR_22'}, --DISTRICT_PUNTA_ORGULL


--UNKNOWN
    --{Hash = 0xFAF570C5, Color = 'BLIP_MODIFIER_MP_COLOR_22'}, --LOCKOUT_EASTSIDE
    --{Hash = 0xAF5E7C06, Color = 'BLIP_MODIFIER_MP_COLOR_22'}, --STATE_DEFAULT
    --{Hash = 0x21FE6ED8, Color = 'BLIP_MODIFIER_MP_COLOR_1'}, --¿?
    --{Hash = 0x28181665, Color = 'BLIP_MODIFIER_MP_COLOR_2'}, --¿?
    --{Hash = 0x33F2D34F, Color = 'BLIP_MODIFIER_MP_COLOR_3'}, --¿?
    --{Hash = 0x3FB16CC9, Color = 'BLIP_MODIFIER_MP_COLOR_4'}, --¿?
    --{Hash = 0x46837F42, Color = 'BLIP_MODIFIER_MP_COLOR_5'}, --¿?
    --{Hash = 0x703A27B1, Color = 'BLIP_MODIFIER_MP_COLOR_6'}, --¿?
    --{Hash = 0x89C0A213, Color = 'BLIP_MODIFIER_MP_COLOR_7'}, --¿?
    --{Hash = 0x90CA4AF8, Color = 'BLIP_MODIFIER_MP_COLOR_8'}, --¿?
    --{Hash = 0x95B1E77A, Color = 'BLIP_MODIFIER_MP_COLOR_9'}, --¿?
    --{Hash = 0xAE021C70, Color = 'BLIP_MODIFIER_MP_COLOR_10'}, --¿?
    --{Hash = 0xBBB91AAD, Color = 'BLIP_MODIFIER_MP_COLOR_11'}, --¿?
    --{Hash = 0xC1C68746, Color = 'BLIP_MODIFIER_MP_COLOR_12'}, --¿?
}
