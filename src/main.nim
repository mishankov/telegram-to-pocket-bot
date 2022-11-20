import jester, json, options, strutils

import config
from telegram/models import TelegramWebhookPayload
from telegram/bot import sendMessage
from pocket import addBookmark

routes:
    get "/":
        resp %*{"status": "OK"}

    post "/tg/wh/@secret":
        cond @"secret" == config.TELEGRAM_BOT_TOKEN

        let payloadJson = parseJson(request.body)
        let payload = to(payloadJson, TelegramWebhookPayload)

        if payload.message.get().from.isSome():
            if $payload.message.get().from.get().id in config.TELEGRAM_ALLOWED_USERS:
                if payload.message.get().text.isSome():
                    discard addBookmark(config.POCKET_CONSUMER_KEY, config.POCKET_ACCESS_TOKEN, payload.message.get().text.get())
                    discard sendMessage(botToken = config.TELEGRAM_BOT_TOKEN, chatId = payload.message.get().from.get().id, text = "Bookmark saved!", parseMode = "HTML")

        resp %*{"status": "OK"}

    post "/tg/wh/@secret":
        resp %*{"status": "wrong secret"}