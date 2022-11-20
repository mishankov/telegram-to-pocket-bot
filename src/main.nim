from os import getEnv
import std/logging

import jester, json, options, strutils

import config
from telegram/models import TelegramWebhookPayload
from telegram/bot import sendMessage
from pocket import addBookmark

var logger = newConsoleLogger(fmtStr="[$time] - $levelname: ")
addHandler(logger)

routes:
    get "/":
        resp %*{"status": "OK"}

    post "/tg/wh/@secret":
        cond @"secret" == config.TELEGRAM_BOT_TOKEN

        let payloadJson = parseJson(request.body)
        let payload = to(payloadJson, TelegramWebhookPayload)

        debug("envs", config.TELEGRAM_BOT_TOKEN, config.TELEGRAM_ALLOWED_USERS, config.POCKET_ACCESS_TOKEN, config.POCKET_CONSUMER_KEY)

        if not payload.message.get().from.isSome():
            resp %*{"status": "no from"}
        if not ($payload.message.get().from.get().id in getEnv("TELEGRAM_ALLOWED_USERS", "none")):
            resp %*{"status": "user not allowed"} 
        if not payload.message.get().text.isSome():
            resp %*{"status": "no text in message"}

        echo addBookmark(config.POCKET_CONSUMER_KEY, config.POCKET_ACCESS_TOKEN, payload.message.get().text.get())
        echo sendMessage(botToken = config.TELEGRAM_BOT_TOKEN, chatId = payload.message.get().from.get().id, text = "Bookmark saved!", parseMode = "HTML")
        resp %*{"status": "OK"}

    post "/tg/wh/@secret":
        debug("envs", config.TELEGRAM_BOT_TOKEN, config.TELEGRAM_ALLOWED_USERS, config.POCKET_ACCESS_TOKEN, config.POCKET_CONSUMER_KEY)

        resp %*{"status": "wrong secret"}