import parsetoml

type
    Config* = object
        telegramBotToken*: string
        telegramAllowedUsers*: string
        pocketConsumerKey*: string
        pocketAccessToken*: string

proc loadConfig*(): Config = 
    let config = parsetoml.parseFile("config.toml")

    return Config(
                telegramBotToken: config["telegramBotToken"].getStr(), 
                telegramAllowedUsers: config["telegramAllowedUsers"].getStr(), 
                pocketConsumerKey: config["pocketConsumerKey"].getStr(), 
                pocketAccessToken: config["pocketAccessToken"].getStr())
