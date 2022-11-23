import std/logging

import jester, json, options, strutils

from config import loadConfig, Config
from telegram/models import TelegramWebhookPayload
from telegram/bot import sendMessage
from pocket import addBookmark

var logger = newConsoleLogger(fmtStr="[$time] - $levelname: ")
addHandler(logger)

let appConfig = loadConfig()

proc logConfig(appConfig: Config) = 
    when not defined(release):
        debug("Logging config")
        debug("telegramBotToken = ", appConfig.telegramBotToken)
        debug("telegramAllowedUsers = ", appConfig.telegramAllowedUsers)
        debug("pocketAccessToken = ", appConfig.pocketAccessToken)
        debug("pocketConsumerKey = ", appConfig.pocketConsumerKey)

logConfig(appConfig)

routes:
    get "/status":
        resp %*{"status": "OK"}

    post "/tg/wh/@secret":
        let appConfig = loadConfig()
        cond @"secret" == appConfig.telegramBotToken

        let payloadJson = parseJson(request.body)
        let payload = to(payloadJson, TelegramWebhookPayload)
        
        logConfig(appConfig)

        if not payload.message.get().from.isSome():
            resp %*{"status": "no from"}
        if not ($payload.message.get().from.get().id in appConfig.telegramAllowedUsers) or appConfig.telegramAllowedUsers == "all":
            resp %*{"status": "user not allowed"} 
        if not payload.message.get().text.isSome():
            resp %*{"status": "no text in message"}

        discard addBookmark(appConfig.pocketConsumerKey, appConfig.pocketAccessToken, payload.message.get().text.get())
        discard sendMessage(botToken = appConfig.telegramBotToken, chatId = payload.message.get().from.get().id, text = "Bookmark saved!", parseMode = "HTML")
        resp %*{"status": "OK"}

    post "/tg/wh/@secret":
        let appConfig = loadConfig()
        logConfig(appConfig)

        resp %*{"status": "wrong secret"}