fx_version 'cerulean'
game 'gta5'

name "behr_blackout"
description "simple blackout script"
author "Behr"
version "1.0.0"

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}

dependencies {
	'ox_lib'
}
