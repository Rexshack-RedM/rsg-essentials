fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

description 'rsg-essentials'
version '2.3.10'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}
files {
    'locales/*.json',
}

dependencies {
    'rsg-core',
    'ox_lib'
}

lua54 'yes'