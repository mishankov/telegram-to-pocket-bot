import std/logging

import parsetoml

type
    Config* = object
        telegramBotToken*: string
        telegramAllowedUsers*: string
        pocketConsumerKey*: string
        pocketAccessToken*: string

#[
    not GC-safe stuff
    https://github.com/nim-lang/Nim/issues/7847
]#
proc loadConfig*(): Config = 
    let configToml = parsetoml.parseFile("config.toml")
    let config = Config(
                telegramBotToken: configToml["telegramBotToken"].getStr(), 
                telegramAllowedUsers: configToml["telegramAllowedUsers"].getStr(), 
                pocketConsumerKey: configToml["pocketConsumerKey"].getStr(), 
                pocketAccessToken: configToml["pocketAccessToken"].getStr()
    )

    when not defined(release):
        debug("Logging config")
        debug("telegramBotToken = ", config.telegramBotToken)
        debug("telegramAllowedUsers = ", config.telegramAllowedUsers)
        debug("pocketAccessToken = ", config.pocketAccessToken)
        debug("pocketConsumerKey = ", config.pocketConsumerKey)

    return config
