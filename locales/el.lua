local Translations = {
    error = {
        var = 'κείμενο εδώ',
    },
    success = {
        var = 'κείμενο εδώ',
    },
    primary = {
        var = 'κείμενο εδώ',
    },
    menu = {
        var = 'κείμενο εδώ',
    },
    commands = {
        emoteMenu = 'Άνοιγμα μενού Emote.',
    },
    progressbar = {
        var = 'κείμενο εδώ',
    },
    label = {
        take_a_drink = 'Πιες ένα ποτό'
    },
    emotes = {
        title = 'Μενού Emote',
        actions = {
            mainMenu = '🚩 Ενέργειες',
            secondMenu = '🚩 Emote Ενεργειών'
        },
        greeting = {
            mainMenu = '👋 Χαιρετισμός',
            secondMenu = '👋 Emote Χαιρετισμών'
        },
        reaction = {
            mainMenu = '🎭 Αντιδράσεις',
            secondMenu = '🎭 Emote Αντιδράσεων'
        },
        taunting = {
            mainMenu = '😡 Προκλήσεις',
            secondMenu = '😡 Emote Προκλήσεων'
        },
        dancing = {
            mainMenu = '💃 Χορός',
            secondMenu = '💃 Emote Χορού'
        },
        close = '❌ Έξοδος'
    },
    log = {
        weapon_removed = 'Το όπλο αφαιρέθηκε!',
        had_weapon_them_that_they_did_not_have = '** @staff ** Ο/Η ${firstname} ${lastname} είχε ένα όπλο που δεν υπήρχε στο απόθεμά του: το anticheat αφαίρεσε το όπλο',
        test_webhook = 'Δοκιμή Webhook',
        webhook_setup_successfully = 'Το Webhook ρυθμίστηκε επιτυχώς',
        test_your_discord_webhook = 'Δοκιμάστε το Webhook σας στο Discord για Logs (Μόνο για Θεούς)',
    },
    afk = {
        will_kick = 'Είστε AFK και θα αποσυνδεθείτε σε ',
        time_seconds = ' δευτερόλεπτα!',
        time_minutes = ' λεπτό(ά)!'
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
