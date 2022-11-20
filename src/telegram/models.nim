import options

type 
    TelegramUser* = object
        id*: uint64

    TelegramMessage* = object
        message_id*: uint64
        `from`*: Option[TelegramUser]
        text*: Option[string]

    TelegramWebhookPayload* = object
        update_id*: uint64
        message*: Option[TelegramMessage]
