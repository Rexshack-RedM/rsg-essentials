# rsg-essentials – Docs (v3.2.1)

## Contents
1. Files
2. Modules
3. Configuration
4. Events, callbacks and commands
5. Key bindings
6. Security
7. Server owner how-tos
8. Troubleshooting

## 1. Files
| File | Purpose |
|---|---|
| `fxmanifest.lua` | Loads `client/*.lua`, `server/*.lua`; depends on `rsg-core` |
| `shared/config.lua` | All settings |
| `client/afk.lua`, `server/afk.lua` | AFK kick |
| `client/discord.lua`, `server/discord.lua` | Discord rich presence |
| `server/logs.lua` | Discord webhook logger (`rsg-log:server:CreateLog`) |
| `client/eagleeye.lua` | Eagle eye access by job |
| `client/firstperson.lua` | First-person free-aim |
| `client/handsup.lua`, `client/pointing.lua` | Hands up, pointing |
| `client/latern.lua` | Lantern holster fix |
| `client/nearwater.lua` | River wash and drink |
| `client/zones.lua` | Map zone colours |
| `client/unlockdoors.lua` | Unlocks a few shop/clinic doors |
| `client/weaponcheck.lua` | Removes held weapons not in inventory |
| `client/maxcores.lua` | Fills cores on character load |
| `client/density.lua` | Ped/animal/vehicle density |
| `client/ignore.lua` | Hide challenge popups, stop auto-shuffle |
| `client/smallfixes.lua` | Drown/boat fix, prompts, stuck wagons, animal cleanup |
| `client/commands.lua` | `/hideui` |
| `server/storm.lua`, `server/xmas.lua` | Restart storm and Christmas weather (rsg-weather) |
| `server/versionchecker.lua` | GitHub version check |
| `locales/*.json` | en, cs, de, el, es, fr, ja, nl, pl, pt-br, ro |

## 2. Modules
| Module | What it does |
|---|---|
| AFK kick | Kicks players standing still for `Config.AFK.KickAfter` seconds with countdown warnings. Groups in `IgnoredGroups` are exempt (checked on client and server) |
| Discord rich presence | App ID, assets, two buttons and live status from `Config.Discord.Template` (`{ID}`, `{NAME}`, `{PLAYERS_COUNT}`) |
| Discord logs | Webhook logger used by many RSG resources |
| Eagle eye | Everyone, or only jobs listed in `Config.EagleEye`; updates on job change |
| First-person aiming | Forces first person while free-aiming (`FirstPersonShooting`) |
| Hands up / pointing | `X` raises/lowers hands (blocked when dead or cuffed); hold `B` to point |
| Lantern holster | Lantern goes back on the hip when switching weapons |
| River wash & drink | Crouch in a named river/lake for Wash and Drink prompts; thirst restored per `Config.River` |
| Map zones | Colours regions in `Config.Zones` |
| Weapon check | Removes any held weapon not in the inventory (uses rsg-weapons) |
| Max cores | Health and stamina cores filled on load |
| Density | Multipliers from `Config.Density` |
| Restart storm | Builds a storm via rsg-weather before a txAdmin scheduled restart |
| Christmas | Snow weather pattern via rsg-weather (`EnableXmas`) |

## 3. Configuration
`shared/config.lua`:
| Option | Default | Meaning |
|---|---|---|
| `Debug` | `false` | Debug prints |
| `AFK` | table | `Enabled`, `KickAfter` (1800 s), `IgnoredGroups`, `WarnAt` (seconds remaining) |
| `River` | table | `DrinkThirst {min,max}`, `DrinkDuration`, `WashDuration` (ms) |
| `EnableAnimalCleanup` | `false` | Remove dead animals every `CleanupInterval` ms |
| `FirstPersonShooting` | `false` | Force first person while aiming |
| `EnableXmas` | `false` | Christmas weather |
| `PauseReadBook` | `false` | Pause-menu book reading |
| `StopAutoShuffle` | `true` | No auto-shuffle to driver seat in wagons |
| `Crouch` | `true` | Require crouching at water |
| `EagleEye` | table | `everyone.enabled`, plus per-job entries (e.g. `vallaw`) |
| `Discord` | table | App ID, assets, buttons, `UpdateEvery`, `Template` |
| `DiscordWHImage/LogUserName/AuthorName` | strings | Webhook look |
| `Density` | table | Multipliers 1–9 (animals, humans, peds, vehicles) |
| `WaterTypes` | table | Named water bodies and types |

Webhook URLs go in `server/logs.lua`.

## 4. Events, callbacks and commands
| Name | Side | Notes |
|---|---|---|
| `rsg-log:server:CreateLog` | server event | `(name, title, color, message, tagEveryone)`. Client calls are rate limited, cannot ping `@everyone` and are stamped with the sender's id |
| `rsg-essentials:server:afkKick` | server event | AFK kick; staff exemption re-checked on the server |
| `rsg-essentials:server:getPermissions` | callback | Used by AFK kick |
| `rsg-discord:getdata` / `rsg-discord:receivedata` | server / client | Rich presence string (rate limited) |
| `rsg-core:client:RemoveWeaponFromTab` | client event | `(weaponName)` removes a weapon from the ped |

| Command | Who | What |
|---|---|---|
| `/hideui` | everyone | Toggle all UI |
| `/testwebhook` | god | Send a test Discord log |

## 5. Key bindings
`X` hands up, hold `B` point, `ENTER` wash, `J` drink (at water while crouched).

## 6. Security
Client-sent logs cannot spam webhooks or ping `@everyone`. The AFK staff exemption is checked on the server. Rich presence requests are rate limited.

## 7. How-tos
- Turn a module off through its config option (e.g. `AFK.Enabled = false`).
- Language: `setr rsg:locale "de"` in server.cfg.
- Start after `rsg-core`, and after `rsg-weather` if you use storm/xmas.

## 8. Troubleshooting
| Problem | Fix |
|---|---|
| No Discord logs | Add webhook URLs in `server/logs.lua`; run `/testwebhook` |
| Rich presence empty | Set `DiscordAppID` and asset names from the Discord Developer Portal |
| Storm/xmas does nothing | rsg-weather must be started |
| Staff kicked for AFK | Add their group to `AFK.IgnoredGroups` |

Support: https://buymeacoffee.com/rexshack
