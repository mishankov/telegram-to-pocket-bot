import std/logging

import jester, json, options, strutils

import config
from telegram/models import TelegramWebhookPayload
from telegram/bot import sendMessage
from pocket import addBookmark

var logger = newConsoleLogger(fmtStr="[$time] - $levelname: ")
addHandler(logger)

proc logConfig*() = 
    # when not defined(release):
        debug("Logging config")
        debug("TELEGRAM_BOT_TOKEN=", config.telegramBotToken())
        debug("TELEGRAM_ALLOWED_USERS=", config.telegramAllowedUsers())
        debug("POCKET_ACCESS_TOKEN=", config.pocketAccessToken())
        debug("POCKET_CONSUMER_KEY=", config.pocketConsumerKey())

logConfig()

routes:
    get "/":
        resp %*{"status": "OK"}

    post "/tg/wh/@secret":
        cond @"secret" == config.telegramBotToken()

        let payloadJson = parseJson(request.body)
        let payload = to(payloadJson, TelegramWebhookPayload)
        
        logConfig()

        if not payload.message.get().from.isSome():
            resp %*{"status": "no from"}
        if not ($payload.message.get().from.get().id in config.telegramAllowedUsers()):
            resp %*{"status": "user not allowed"} 
        if not payload.message.get().text.isSome():
            resp %*{"status": "no text in message"}

        discard addBookmark(config.pocketConsumerKey(), config.pocketAccessToken(), payload.message.get().text.get())
        discard sendMessage(botToken = config.telegramBotToken(), chatId = payload.message.get().from.get().id, text = "Bookmark saved!", parseMode = "HTML")
        resp %*{"status": "OK"}

    post "/tg/wh/@secret":
        logConfig()

        resp %*{"status": "wrong secret"}