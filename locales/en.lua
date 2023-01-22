local Translations = {
    error = {
        you_are_will_be_kicked_in = 'You are AFK and will be kicked in ${time} minute(s)!',
        you_are_and_will_be_kicked_in_seconds = 'You are AFK and will be kicked in ${time} seconds!'
    },
    success = {
		    var = 'text goes here',
    },
    primary = {
		    var = 'text goes here',
    },
    menu = {
		    var = 'text goes here',
    },
    commands = {
		    var = 'text goes here',
    },
    progressbar = {
		    var = 'text goes here',
    },
    label = {
        take_a_drink = 'Take a Drink'
    },
    log = {
        weapon_removed = 'Weapon Removed!',
        had_weapon_them_that_they_did_not_have = '** @staff ** ${firstname} ${lastname} had a weapon on them that they did not have in his inventory : anticheat has removed the weapon',
        test_webhook = 'Test Webhook',
        webhook_setup_successfully = 'Webhook setup successfully',
        test_your_discord_webhook = 'Test Your Discord Webhook For Logs (God Only)',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
