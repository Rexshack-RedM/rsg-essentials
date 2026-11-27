local RSGCore = exports['rsg-core']:GetCoreObject()

-- add your discord webhook urls here (empty = channel disabled, falls back to 'default')
local Webhooks = {
    ['default'] = '',
    ['testwebhook'] = '',
    ['anticheat'] = '',
    ['levels'] = '',
    ['playermoney'] = '',
    ['joinleave'] = '',
    ['banking'] = '',
    ['ooc'] = '',
    ['playerinventory'] = '',
    ['robbing'] = '',
    ['stash'] = '',
    ['drop'] = '',
    ['dealers'] = '',
    ['shops'] = '',
    ['bans'] = '',
    ['bossmenu'] = '',
    ['gangmenu'] = '',
    ['fishing'] = '',
    ['goldpanning'] = '',
    ['loot'] = '',
    ['hotel'] = '',
    ['beekeeper'] = '',
    ['ranch'] = '',
    ['adminmenu'] = '',
    ['report'] = '',
    ['horsetrainer'] = '',
    ['crafting'] = '',
    ['death'] = '',
}

local Colors = {
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ['lightgreen'] = 65309,
}

local CLIENT_COOLDOWN = 2 -- seconds between client-sent logs per player
local lastClientLog = {}

-- Logs are queued per webhook and sent in batches (up to 10 embeds per request) so bursts stay inside
-- Discord's rate limit. Failed sends are retried; a full queue drops the oldest entry.
local SEND_INTERVAL = 2000  -- ms between requests to the same webhook
local MAX_EMBEDS = 10       -- Discord limit per message
local MAX_CHARS = 5500      -- Discord allows 6000 characters across all embeds in a message
local MAX_QUEUE = 500       -- per webhook
local MAX_ATTEMPTS = 4

local queues = {} -- [url] = { items = {}, busy = false, dropped = 0 }

local function embedSize(embed)
    return #(embed.title or '') + #(embed.description or '') + #(embed.footer.text or '') + #(embed.author.name or '')
end

local function takeBatch(items)
    local batch, size, tag = {}, 0, false
    while #items > 0 and #batch < MAX_EMBEDS do
        local length = embedSize(items[1].embed)
        if #batch > 0 and size + length > MAX_CHARS then break end
        local item = table.remove(items, 1)
        batch[#batch + 1] = item
        size = size + length
        tag = tag or item.tag
    end
    return batch, tag
end

local function send(url, payload)
    local p = promise.new()
    PerformHttpRequest(url, function(status, body, headers, errorData)
        p:resolve({ status = tonumber(status) or 0, body = body or errorData, headers = headers })
    end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
    return Citizen.Await(p)
end

local function retryDelay(response)
    local text = type(response.body) == 'string' and response.body or ''
    local seconds = tonumber(text:match('"retry_after"%s*:%s*([%d%.]+)'))
    return math.min(60000, math.ceil((seconds or 5) * 1000))
end

local function process(url)
    local queue = queues[url]
    if queue.busy then return end
    queue.busy = true
    CreateThread(function()
        Wait(250) -- let a burst collect into one message
        local attempts = 0
        while #queue.items > 0 do
            local batch, tag = takeBatch(queue.items)
            local embeds = {}
            for i = 1, #batch do embeds[i] = batch[i].embed end
            local response = send(url, { username = Config.DiscordWHLogUserName, content = tag and '@everyone' or nil, embeds = embeds })
            local delay = SEND_INTERVAL
            if response.status == 429 or response.status >= 500 or response.status == 0 then
                attempts = attempts + 1
                delay = response.status == 429 and retryDelay(response) or 5000
                -- rate limits are always retried; other failures give up after a few attempts
                if response.status == 429 or attempts < MAX_ATTEMPTS then
                    for i = #batch, 1, -1 do table.insert(queue.items, 1, batch[i]) end
                else
                    attempts = 0
                    print(('^3[rsg-essentials] dropped %d Discord log(s) after HTTP %d^7'):format(#batch, response.status))
                end
            else
                attempts = 0
                if response.status >= 300 then
                    print(('^3[rsg-essentials] Discord rejected %d log(s): HTTP %d^7'):format(#batch, response.status))
                end
            end
            if queue.dropped > 0 then
                print(('^3[rsg-essentials] Discord log queue was full, dropped %d old log(s)^7'):format(queue.dropped))
                queue.dropped = 0
            end
            Wait(delay)
        end
        queue.busy = false
    end)
end

local function sendLog(name, title, color, message, tagEveryone)
    local url = Webhooks[name]
    if not url or url == '' then url = Webhooks['default'] end
    if not url or url == '' then return end

    local queue = queues[url]
    if not queue then
        queue = { items = {}, busy = false, dropped = 0 }
        queues[url] = queue
    end
    if #queue.items >= MAX_QUEUE then
        table.remove(queue.items, 1)
        queue.dropped = queue.dropped + 1
    end

    queue.items[#queue.items + 1] = {
        tag = tagEveryone == true,
        embed = {
            title = tostring(title or ''):sub(1, 256),
            color = Colors[color] or Colors['default'],
            description = tostring(message or ''):sub(1, 4000),
            footer = { text = os.date('%c') }, -- time the event happened, not when it was sent
            author = { name = Config.DiscordWHAuthorName, icon_url = Config.DiscordWHImage },
        },
    }
    process(url)
end

-- server resources: TriggerEvent('rsg-log:server:CreateLog', name, title, color, message, tagEveryone)
-- clients may still send logs (rsg-adminmenu does), but are rate limited, can't @everyone
-- and are tagged with their server id so spoofed logs are traceable
RegisterNetEvent('rsg-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local src = tonumber(source)
    if type(name) ~= 'string' then return end
    title, message = tostring(title or ''):sub(1, 256), tostring(message or ''):sub(1, 4000)

    if src and src > 0 then
        local now = os.time()
        if lastClientLog[src] and now - lastClientLog[src] < CLIENT_COOLDOWN then return end
        lastClientLog[src] = now
        tagEveryone = false
        message = ('%s\n\n`client: [%d] %s`'):format(message, src, GetPlayerName(src) or '?')
    end

    sendLog(name, title, color, message, tagEveryone == true)
end)

AddEventHandler('playerDropped', function()
    lastClientLog[source] = nil
end)

RSGCore.Commands.Add('testwebhook', locale('sv_test_your_webhook'), {}, false, function()
    sendLog('testwebhook', locale('sv_test_webhook'), 'default', locale('sv_webhook_successfully'))
end, 'god')
