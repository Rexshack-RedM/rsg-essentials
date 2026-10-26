<img width="2948" height="497" alt="rsg_framework" src="https://github.com/user-attachments/assets/638791d8-296d-4817-a596-785325c1b83a" />

# 🧰 rsg-essentials
**Quality-of-life utilities and fixes for RedM using RSG Core.**

![Platform](https://img.shields.io/badge/platform-RedM-darkred)
![License](https://img.shields.io/badge/license-GPL--3.0-green)

> A collection of small but essential features: AFK kick, Discord rich presence, eagle eye access, first-person shooting handling, map zone labels, door unlocks, water interactions, and more. Modular client/server files make it easy to enable only what you need.

---

## 🛠️ Dependencies
- [**rsg-core**](https://github.com/Rexshack-RedM/rsg-core) 🤠
- [**ox_lib**](https://github.com/Rexshack-RedM/ox_lib) ⚙️ *(locales, progress bars, UI)*
- [**oxmysql**](https://github.com/overextended/oxmysql) 🗄️ *(logs where applicable)*
- [**rsg-inventory**](https://github.com/Rexshack-RedM/rsg-inventory) 🎒 *(for certain inventory interactions)*
- [**ox_target**](https://github.com/overextended/ox_target) 🎯 *(for water pump interaction)*
- [**weathersync**](https://github.com/Rexshack-RedM/weathersync) 🌦️
- [**rsg-weapons**](https://github.com/Rexshack-RedM/rsg-weapons) 🔫 *(for weapon check/remove events)*

**Locales:** `locales/en.json, fr.json, es.json, pt-br.json` (loaded via `lib.locale()`).  
**Config:** `config.lua` exposes toggles and parameters for each module.

---

## ✨ Features (by module)

### 👞 AFK Kick (`client/afk.lua`, `server/afk.lua`)
- Kicks AFK players after a timeout (default **1800s**).
- Staff groups (`mod`, `admin`, `god`) are exempt.
- Client shows step-down warnings; server handles **DropPlayer**.

### 🦅 Eagle Eye Access (`client/eagleeye.lua`)
- Per‑job control via `Config.EagleEye`: allow **everyone**, or only specific jobs (`vallaw`, `rholaw`, etc.).
- Automatically enables/disables on resource start/stop and player job changes.

### 🎮 First Person Shooting (`client/firstperson.lua`)
- If `Config.FirstPersonShooting = true`, forces first‑person while free‑aiming, and restores afterward.

### 🙌 Hands Up (`client/handsup.lua`)
- Simple hands‑up behaviour with task cleanup and taser handling.

### 💬 Discord Rich Presence (`client/discord.lua`, `server/discord.lua`)
- Uses **Discord Application ID** and asset IDs from `Config.Discord`.
- Two buttons (text + links) and live **Rich Presence** updates with `{ID}`, `{NAME}`, `{PLAYERS_COUNT}` replacement in `Config.Discord.Template`.

### 🗺️ Map Zones (`client/zones.lua`)
- Adds localized **zone/region/territory** names; credit to **Viyu88** (see file header).

### 🔓 Unlock Doors (`client/unlockdoors.lua`)
- Unlocks a curated set of shop/clinic doors by hash at resource start.

### 💧 Near Water & Water Pump (`client/nearwater.lua`, `client/waterpump.lua`)
- Wash/drink prompts near natural water sources with `RSGCore.Shared.Keybinds` prompts.
- **Water pump** interactions via **ox_target**; fills canteen items (checks `canteen0`), plays progress bar and animation.

### 👆 Pointing (`client/pointing.lua`)
- Enables RDR2 pointing with proper task toggles.

### 🔧 Small Fixes (`client/smallfixes.lua`)
- Wagon driver seat handling and minor QoL fixes.

### 🧠 Density (`client/density.lua`)
- Control peds/traffic/animal density using natives.

### 🧍 Stop Auto Shuffle (`config.lua`)
- Option to stop auto-shuffle to driver seat for wagons (`Config.StopAutoShuffle = true`).

### 🔫 Weapon Check (`client/weaponcheck.lua`)
- Removes weapons from ped slots on event `rsg-core:client:RemoveWeaponFromTab`, integrates with `rsg-weapons` and unequips if needed.

### 🌩️ Storm & Xmas (`server/storm.lua`, `server/xmas.lua`)
- **Storm**: reacts to `txAdmin:events:announcement` to trigger thunderstorm prints and optional weather sync.
- **Xmas**: toggles Xmas weather with `weathersync` (if `Config.EnableXmas = true`).

### 📝 Logs (`server/logs.lua`)
- Webhook‑based logging (configure `Webhooks` table) with fallbacks to default channel.

---

## 📜 Example Config Highlights
```lua
Config.Debug = false
Config.FirstPersonShooting = false
Config.EnableXmas = false
Config.PauseReadBook = false
Config.StopAutoShuffle = true

Config.EagleEye = {
  everyone = { enabled = true },
  vallaw = { enabled = false },
  rholaw = { enabled = false }
}

Config.Discord = {
  DiscordAppID = 12345678910111213,
  AppBigAssetID = 'big_img.png!',
  AppBigAssetText = 'big text img!',
  AppSmallAssetID = 'small_img.png!',
  AppSmallAssetText = 'small text img!',
  FirstButtonPlaceholder = 'Discord',
  FirstButtonLink = 'https://discord.gg/yourserver',
  SecondButtonPlaceholder = 'Website',
  SecondButtonLink = 'https://example.com',
  UpdateEvery = 15000,
  Template = '{NAME} (ID: {ID}) | {PLAYERS_COUNT} online'
}

-- Water areas and pumps are configured in config.lua and client files
```

---

## 📂 Installation
1. Place `rsg-essentials` inside your `resources/[rsg]` folder.
2. Ensure **rsg-core**, **ox_lib**, **ox_target**, and any optional dependencies you use are installed.
3. Configure `config.lua` (Discord, Eagle Eye, Xmas, etc.).
4. Add to your `server.cfg`:
   ```cfg
   ensure ox_lib
   ensure rsg-core
   ensure ox_target
   ensure rsg-essentials
   ```
5. Restart your server.

---

## 🌍 Locales
Provided in `locales/`: `en`, `fr`, `es`, `pt-br`.  
`lib.locale()` is used across client/server modules.

---

## 💎 Credits
- Map Zones data credit to **Viyu88** (see `client/zones.lua`).  
- RSG / Rexshack-RedM and community contributors.  
- License: **GPL‑3.0**.
