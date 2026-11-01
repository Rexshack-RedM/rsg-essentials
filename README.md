<img width="2948" height="497" alt="rsg_framework" src="https://github.com/user-attachments/assets/638791d8-296d-4817-a596-785325c1b83a" />

# 🧰 rsg-essentials
**Quality-of-life utilities and fixes for RedM using RSG Core.**

![Platform](https://img.shields.io/badge/platform-RedM-darkred)
![License](https://img.shields.io/badge/license-GPL--3.0-green)

> A collection of small but essential features: AFK kick, Discord rich presence, Discord logging, eagle eye access, hands up / pointing, lantern holstering, river wash & drink, map zone colours, door unlocks, PvP toggle, restart storm, Christmas weather and more.

---

## 🛠️ Dependencies
- [**rsg-core**](https://github.com/Rexshack-RedM/rsg-core) 🤠 *(locales, notify, callbacks, commands — no ox_lib needed)*

**Optional**
- [**rsg-weather**](https://github.com/Rexshack-RedM/rsg-weather) 🌦️ *(restart storm + Christmas weather)*
- [**rsg-weapons**](https://github.com/Rexshack-RedM/rsg-weapons) 🔫 *(weapon remove event)*
- [**rsg-radialmenu**](https://github.com/Rexshack-RedM/rsg-radialmenu) *(PvP toggle button)*

**Locales:** `en, de, el, es, fr, ja, nl, pl, pt-br, ro` (+ `cs`) loaded by rsg-core. Set the language with `setr rsg:locale de`.

---

## ✨ Features

| Module | Files | What it does |
|---|---|---|
| AFK kick | `client/afk.lua`, `server/afk.lua` | Kicks players who stand still for `Config.AFK.KickAfter` seconds, with countdown warnings. Staff groups in `Config.AFK.IgnoredGroups` are exempt (checked on client **and** server). |
| Discord rich presence | `client/discord.lua`, `server/discord.lua` | App ID, assets, two buttons and a live status from `Config.Discord.Template` (`{ID}`, `{NAME}`, `{PLAYERS_COUNT}`). |
| Discord logs | `server/logs.lua` | `rsg-log:server:CreateLog` webhook logger used by many RSG resources. `/testwebhook` (god). |
| Eagle eye | `client/eagleeye.lua` | Everyone, or only jobs listed in `Config.EagleEye`. Updates on job change. |
| First-person aiming | `client/firstperson.lua` | Forces first person while free-aiming (`Config.FirstPersonShooting`). |
| Hands up | `client/handsup.lua` | `X` raises / lowers hands (blocked when dead or cuffed), sets `inv_busy`. |
| Pointing | `client/pointing.lua` | Hold `B` to point. |
| Lantern holster | `client/latern.lua` | Puts the lantern back on the hip when switching weapons. |
| River wash & drink | `client/nearwater.lua` | Crouch in a named river/lake for **Wash** (`ENTER`) and **Drink** (`J`) prompts. Thirst amount and timings in `Config.River`. |
| Map zones | `client/zones.lua` | Colours map regions listed in `Config.Zones` (credit Viyu88). |
| Door unlocks | `client/unlockdoors.lua` | Unlocks a few shop / clinic doors. |
| Weapon check | `client/weaponcheck.lua` | Removes any held weapon that isn't in the player's inventory. |
| Max cores | `client/maxcores.lua` | Fills health & stamina cores on character load. |
| Density | `client/density.lua` | Ped / animal / vehicle density multipliers from `Config.Density`. |
| Ignore events | `client/ignore.lua` | Hides challenge popups; stops auto-shuffle to the driver seat (`Config.StopAutoShuffle`). |
| Small fixes | `client/smallfixes.lua` | Drown / boat-sink fix, disabled left-alt HUD & loadout prompt, stuck ambient wagon removal, pause-menu book reading (`Config.PauseReadBook`), dead animal cleanup (`Config.EnableAnimalCleanup`), PvP toggle event. |
| Hide UI | `client/commands.lua` | `/hideui` toggles all UI. |
| Restart storm | `server/storm.lua` | Builds up a storm via rsg-weather before a txAdmin scheduled restart. |
| Christmas | `server/xmas.lua` | Snow weather pattern via rsg-weather (`Config.EnableXmas`). |
| Version check | `server/versionchecker.lua` | Checks GitHub for updates on start. |

---

## 📡 Events & callbacks
| Name | Side | Notes |
|---|---|---|
| `rsg-essentials:client:pvpToggle` | client | Toggles PvP / friendly fire. |
| `rsg-log:server:CreateLog` | server | `(name, title, color, message, tagEveryone)`. Server calls are unrestricted; client calls are rate limited, can't `@everyone` and are stamped with the sender's id. |
| `rsg-core:client:RemoveWeaponFromTab` | client | Removes a weapon from the ped (rsg-weapons). |
| `rsg-essentials:server:getPermissions` | callback | Used by AFK kick. |

---

## ⚙️ Installation
1. Put `rsg-essentials` in `resources/[framework]`.
2. `ensure rsg-essentials` after `rsg-core` (and after `rsg-weather` if you use the storm/xmas features).
3. Add your webhook URLs in `server/logs.lua` and Discord app details in `Config.Discord`.
4. Adjust `shared/config.lua` and restart.

---

## 📝 Changelog — 3.2.0
- Removed the ox_lib dependency (rsg-core locales / notify, `cache.ped` → `PlayerPedId()`).
- **Security:** client-sent `rsg-log:server:CreateLog` can no longer spam webhooks or ping `@everyone`.
- **Security:** AFK staff exemption re-checked on the server; event renamed to `rsg-essentials:server:afkKick`.
- Rich presence requests rate limited.
- Christmas weather ported from weathersync to rsg-weather (was silently doing nothing).
- Fixed AFK minute warnings showing "seconds"; warnings now replace each other instead of stacking.
- Fixed lantern holster logic (dead branches), river drink erroring on undefined globals, thirst now clamped 0–100, prompts cleaned up on stop.
- Stuck-wagon fix and animal cleanup no longer touch player-driven, script-owned or other clients' entities.
- Hands up no longer reloads the anim dict every press; resets `inv_busy` on stop. Eagle eye no longer errors on restart before login.
- Removed dead code: ~350-line unused `zoneNames` table, DataView library (replaced with a few lines), commented-out thread, unused canteen config/locales.
- Added `el`, `ja`, `nl`, `ro` locales; all locale files share the same keys.

---

## 💎 Credits
- RSG / Rexshack-RedM and community contributors
- Viyu88 (map zone colours), rms_dnb (animal cleanup)
- License: GPL-3.0

Support: https://buymeacoffee.com/rexshack
