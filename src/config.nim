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
    let config = parsetoml.parseFile("config.toml")

    return Config(
                telegramBotToken: config["telegramBotToken"].getStr(), 
                telegramAllowedUsers: config["telegramAllowedUsers"].getStr(), 
                pocketConsumerKey: config["pocketConsumerKey"].getStr(), 
                pocketAccessToken: config["pocketAccessToken"].getStr())
