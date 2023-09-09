local Translations = {
error = {
    var = 'o texto vai aqui',
},
success = {
    var = 'o texto vai aqui',
},
primary = {
    var = 'o texto vai aqui',
},
menu = {
    var = 'o texto vai aqui',
},
commands = {
    emoteMenu = 'Abrir menu de emotes.',
},
progressbar = {
    var = 'o texto vai aqui',
},
label = {
    take_a_drink = 'Bebendo',
},
emotes = {
    title = ' Menu de Emotes',
    actions = {
        mainMenu = '🚩 Ações',
        secondMenu = '🚩 Emotes de Ações',
    },
    greeting = {
        mainMenu = '👋 Saudações',
        secondMenu = '👋 Emotes de Saudações',
    },
    reaction = {
        mainMenu = '🎭 Reações',
        secondMenu = '🎭 Emotes de Reações',
    },
    taunting = {
        mainMenu = '😡 Provocações',
        secondMenu = '😡 Emotes de Provocações',
    },
    dancing = {
        mainMenu = '💃 Danças',
        secondMenu = '💃 Emotes de Danças',
    },
    close = '❌ Sair',
},
log = {
    weapon_removed = 'Arma Removida!',
    had_weapon_them_that_they_did_not_have = '** @staff ** ${firstname} ${lastname} tinha uma arma que não estava em seu inventário: o sistema anticheat removeu a arma',
    test_webhook = 'Testar Webhook',
    webhook_setup_successfully = 'Webhook configurado com sucesso',
    test_your_discord_webhook = 'Testar seu Webhook do Discord para Logs (Somente para Administradores)',
},
afk = {
    will_kick = 'Você está AFK e será expulso em ',
    time_seconds = ' segundo(s)!',
    time_minutes = ' minuto(s)!',
},
}

if GetConvar('rsg_locale', 'en') == 'pt-br' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
