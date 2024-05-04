local Translations = {
    error = {
        var = 'testo qui',
    },
    success = {
            var = 'testo qui',
    },
    primary = {
            var = 'testo qui',
    },
    menu = {
            var = 'testo qui',
    },
    commands = {
        emoteMenu = 'Apri menu emote.',
    },
    progressbar = {
            var = 'testo qui',
    },
    label = {
        take_a_drink = 'Prendi una bevanda'
    },
    emotes = {
        title = ' Menu Emote',
        actions = {
            mainMenu = '🚩 Azioni',
            secondMenu = '🚩 Emote Azioni'
        },
        greeting = {
            mainMenu = '👋 Saluto',
            secondMenu = '👋 Emote Saluto'
        },
        reaction = {
            mainMenu = '🎭 Reazioni',
            secondMenu = '🎭 Emote Reazioni'
        },
        taunting = {
            mainMenu = '😡 Provocazione',
            secondMenu = '😡 Emote Provocazione'
        },
        dancing = {
            mainMenu = '💃 Danza',
            secondMenu = '💃 Emote Danza'
        },
        close = '❌ Chiudi'
    },
    log = {
        weapon_removed = 'Arma Rimossa!',
        had_weapon_them_that_they_did_not_have = '** @staff ** ${firstname} ${lastname} aveva un'arma su di loro che non avevano nel loro inventario: il sistema anticheat ha rimosso l'arma',
        test_webhook = 'Test Webhook',
        webhook_setup_successfully = 'Webhook configurato con successo',
        test_your_discord_webhook = 'Testa il tuo Webhook Discord per i Log (Solo per gli Dei)',
    },
    afk = {
        will_kick = 'Sei AFK e verrai kickato tra ',
        time_seconds = ' secondi!',
        time_minutes = ' minuto(i)!'
    },
}

if GetConvar('rsg_locale', 'en') == 'it' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
